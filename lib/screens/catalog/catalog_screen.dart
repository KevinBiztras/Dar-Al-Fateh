/*
 * *
 *
 *  Webkul Software.
 *
 *  @package Mobikul App
 *
 *  @Category Mobikul
 *
 *  @author Webkul <support@webkul.com>
 *
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *
 *  @license https://store.webkul.com/license.html ASL Licence
 *
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'dart:async';

/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
// import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/catalog/bloc/catalog_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/views/product_item_full_width.dart';
import 'package:flutter_project_structure/screens/home/views/product_list_widgets/product_list_widgets.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_repository.dart';
import '../../constants/arguments_map.dart';
import '../../models/FilterDataModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';


// import '../../marketplace/marketplaceConstant/marketplace_arguments_map.dart';
// import '../../marketplace/marketplaceModel/CatalogArgumentModel.dart';

class CatalogScreen extends StatefulWidget {
  final Map<String, dynamic> catalogScreenPassData;

  CatalogScreen(this.catalogScreenPassData);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ScrollController _scrollController = ScrollController();
  AppLocalizations? _localizations;
  String imageUrl = '';
  bool isLoading = true;
  bool isGridViewShowing = true;
  CatalogScreenBloc? catalogScreenBloc;
  GetFilterAttribute? model;
  int offset = 0;
  bool isFromPagination = false;
  List<Products> productList = [];
  StreamController<bool>? buildScreen;
  String categoryName = '';
  bool isFilter = false;
  String? selectedSorting;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    catalogScreenBloc = context.read<CatalogScreenBloc>();

    // if (widget.catalogScreenPassData[fromMarketplaceKey] ?? false) {
    //   catalogScreenBloc?.add(SellerCatalogDataFetchEvent(CatalogArgumentModel(
    //       limit: widget.catalogScreenPassData[limitKey],
    //       offset: widget.catalogScreenPassData[offsetKey],
    //       domain: widget.catalogScreenPassData[sellerIdKey])));
    // }
    if (widget.catalogScreenPassData[fromNotificationKey]) {
      catalogScreenBloc?.add(
        CatalogScreenDataFetchFromNotificationEvent(
          10,
          widget.catalogScreenPassData[domainKey],
        ),
      );
    } else {
      widget.catalogScreenPassData[fromHomePageKey]
          ? catalogScreenBloc?.add(
              CatalogScreenDataFetchFromHomeEvent(
                widget.catalogScreenPassData[urlKey],
                10,
                0,
              ),
            )
          : catalogScreenBloc?.add(
              CatalogScreenDataFetchEvent(
                widget.catalogScreenPassData[customerIdKey],
                10,
                0,
                AppSharedPref().getSplashData()?.sortData?.first.code ?? "",
              ),
            );
    }
    AppBarName();
    buildScreen = StreamController<bool>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(productList.isEmpty){
      for(int i=0;i<10;i++){
        productList.add(Products(
          name: 'Demo Product ${i+1}',
          priceUnit: "\$${(i + 1) * 25}.99",
          productId: i
        ));
      }
      
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 58),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonAppBar(
              categoryName,
              context,
              isElevated: false,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, searchPage);
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      isGridViewShowing = true;
                      List<dynamic> attributeValue = [];
                      for (var item in model?.applied_filters ?? []) {
                        List<AppliedFiltersValue> appliedFiltersValue =
                            item.applied_filters_value ?? [];
                        if (appliedFiltersValue.isNotEmpty) {
                          for (var attr in appliedFiltersValue) {
                            if (!attributeValue.contains([item.id, attr.id])) {
                              attributeValue.add([item.id, attr.id]);
                            } else {
                              attributeValue.remove([item.id, attr.id]);
                            }
                          }
                        }
                      }

                      Navigator.pushNamed(
                        context,
                        catalogFilterPage,
                        arguments: getFilterDetailDataMap(
                          model?.max_price ?? model?.availableMaxPrice ?? 0,
                          model?.min_price ?? model?.availableMinPrice ?? 0,
                          model?.applied_category_id ??
                              widget.catalogScreenPassData[customerIdKey],
                          attributeValue,
                        ),
                      ).then((value) {
                        if (value != null) {
                          productList.clear();
                          offset = 0;
                          setState(() {
                            isLoading = true;
                          });
                          catalogScreenBloc?.add(
                            FilterFetchDataEvent(value as Map<String, dynamic>),
                          );
                          setState(() {
                            isFilter = true;
                          });
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.filter_list_alt, size: 28),
                        SizedBox(width: 8.0),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.translate(AppStringConstant.filter) ??
                              "",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        catalogSortPage,
                        arguments: selectedSorting ?? "",
                      ).then((value) {
                        if (value != null) {
                          productList.clear();
                          offset = 0;
                          setState(() {
                            isLoading = true;
                          });
                          catalogScreenBloc?.add(
                            CatalogScreenDataFetchEvent(
                              widget.catalogScreenPassData[customerIdKey],
                              10,
                              offset,
                              value as String,
                            ),
                          );

                          setState(() {
                            selectedSorting = value as String;
                          });
                        }
                      });
                      ;
                    },
                    child: Row(
                      children: [
                        Icon(Icons.sort_sharp, size: 28),
                        SizedBox(width: 8.0),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.translate(AppStringConstant.sort) ??
                          "",

                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGridViewShowing = !isGridViewShowing;
                      });
                      buildScreen?.sink.add(isGridViewShowing);
                    },
                    child: Row(
                      children: [
                        Icon(
                          isGridViewShowing ? Icons.grid_view : Icons.list,
                          size: 28,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          isGridViewShowing
                              ? AppLocalizations.of(
                                      context,
                                    )?.translate(AppStringConstant.grid) ??
                                    ""
                              : AppLocalizations.of(
                                      context,
                                    )?.translate(AppStringConstant.list) ??
                                    "",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
        builder: (context, state) {
          if (state is CatalogScreenInitialState) {
            if (!isFromPagination) {
              isLoading = true;
            }
          } else if (state is CatalogScreenSuccessState) {
            model = state.categoryScreenModel;
            AppSharedPref().setWishlistData(
              state.categoryScreenModel!.wishlist,
            );
            if (offset == 0) {
              productList = model?.products ?? [];
            } else {
              productList.addAll(model?.products ?? []);
            }
            isLoading = false;
            isFromPagination = false;
          } else if (state is CatalogDataFromNotificationSuccessState) {
            isLoading = false;
            model = state.categoryScreenModel;
            productList = model?.products ?? [];
            AppSharedPref().setWishlistData(
              state.categoryScreenModel!.wishlist,
            );
          } else if (state is FilterFetchState) {
            isLoading = false;
            if (offset == 0) {
              productList = state.filterModel?.products ?? [];
            } else {
              productList.addAll(state.filterModel?.products ?? []);
            }
            model = state.filterModel;
            if (isFilter) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppBarName();
              });
            }
          } else if (state is CatalogScreenErrorState) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(state.message ?? '', context);
            });
          }
          return
          // isLoading
          //     ? Loader()
          //     :
          Stack(
            children: [
              Visibility(
                visible: model?.products?.isNotEmpty ?? true,
                child: RefreshIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  onRefresh: () async {
                    isFromPagination = false;
                    offset = 0;
                    setState(() {
                      isLoading = true;
                    });
                    if (widget.catalogScreenPassData[fromNotificationKey]) {
                      catalogScreenBloc?.add(
                        CatalogScreenDataFetchFromNotificationEvent(
                          10,
                          widget.catalogScreenPassData[domainKey],
                        ),
                      );
                    } else {
                      widget.catalogScreenPassData[fromHomePageKey]
                          ? catalogScreenBloc?.add(
                              CatalogScreenDataFetchFromHomeEvent(
                                widget.catalogScreenPassData[urlKey],
                                10,
                                0,
                              ),
                            )
                          : catalogScreenBloc?.add(
                              CatalogScreenDataFetchEvent(
                                widget.catalogScreenPassData[customerIdKey],
                                10,
                                0,
                                AppSharedPref()
                                        .getSplashData()
                                        ?.sortData
                                        ?.first
                                        .code ??
                                    "",
                              ),
                            );
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController
                      ..addListener(() {
                        paginationFunction();
                      }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.imageRadius,
                      ),
                      child: Column(
                        children: [
                          isGridViewShowing
                              ? buildGridProduct(
                                  productList,
                                  _localizations,
                                  isCatalog: true,
                                  postWishlistClick: postWishlistClick,
                                  onAddToCart: (p, qty) => addToCart(p, qty),
                                )
                              : listView(productList),
                          Visibility(
                            visible: isFromPagination,
                            child: Loader(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible:
                    (!isLoading) && !(model?.products?.isNotEmpty ?? false),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.imageRadius),
                  child: Center(
                    child: Text(
                      _localizations?.translate(
                            AppStringConstant.noProductFound,
                          ) ??
                          '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //------------Show vertical moving list---------------//
  Widget listView(List<Products> productList) {
    print('List Callback--${productList.length}');
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = productList;
        return ProductItemFullWidth(product: data[index],onAddToCart: addToCart,);
      },
    );
  }

  //--------------------Handle load more----------------------//
  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (model?.tcount ?? 0) != productList.length) {
      // setState(() {
      if (model?.offset == offset && (offset + 10) < (model?.tcount ?? 0)) {
        offset += 10;
        catalogScreenBloc = context.read<CatalogScreenBloc>();
        print("checking${offset}");
        widget.catalogScreenPassData[fromHomePageKey]
            ? catalogScreenBloc?.add(
                CatalogScreenDataFetchFromHomeEvent(
                  widget.catalogScreenPassData[urlKey],
                  10,
                  offset,
                ),
              )
            : catalogScreenBloc?.add(
                CatalogScreenDataFetchEvent(
                  widget.catalogScreenPassData[customerIdKey],
                  10,
                  offset,
                  AppSharedPref().getSplashData()?.sortData?.first.code ?? "",
                ),
              );
        isFromPagination = true;
        setState(() {
          isLoading = true;
        });
      }
      // });
    }
  }

  void addToCart(Products product, [int quantity = 1]) async {
    // Try to obtain a CartScreenBloc if present in the widget tree.
    CartScreenBloc? cartBloc;
    try {
      cartBloc = context.read<CartScreenBloc>();
    } catch (e) {
      cartBloc = null;
    }

    // If a CartScreenBloc is available (e.g. Cart page open), use it so the
    // Cart UI (CartMainView) will receive events and refresh automatically.
    if (cartBloc != null) {
      // Dispatch event to add product
      cartBloc.add(AddToCartEvent(product.productId ?? 0));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} added to cart')),
      );

      try {
        final state = await cartBloc.stream.firstWhere((s) =>
            s is AddToCartItemSuccess || s is CartScreenError);
        if (state is AddToCartItemSuccess) {
          AlertMessage.showSuccess(state.data.message ?? '', context);
          // refresh cart data/count
          cartBloc.add(const CartScreenDataFetchEvent());
        } else if (state is CartScreenError) {
          AlertMessage.showError(state.message ?? '', context);
        }
      } catch (_) {
        // ignore: avoid_print
        print('Add to cart: no response from CartBloc');
      }
      return;
    }

    // If no CartScreenBloc is available, call the repository directly so adding
    // to cart still works when the Cart page isn't in the widget tree.
    try {
      final repository = ProductScreenRepositoryImp();
      final model = await repository.addTocart(
          product.productId!.toString(), quantity);
      if (model.success ?? false) {
        AlertMessage.showSuccess(model.message ?? '', context);
        // keep guest cart count up-to-date for badges etc.
        AppSharedPref().setGuestCartCount(model.cartCount ?? 0);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} added to cart')),
        );
      } else {
        AlertMessage.showError(model.message ?? '', context);
      }
    } catch (error) {
      debugPrint(error.toString());
      AlertMessage.showError(error.toString(), context);
    }
  }

  void AppBarName() {
    var category;
    if (model?.applied_category_id == null) {
      categoryName = widget.catalogScreenPassData[categoryNameKey];
    } else {
      if (model?.categories?.any(
            (i) => i.categoryId == model?.applied_category_id,
          ) ??
          false) {
        var category = model?.categories?.firstWhere(
          (i) => i.categoryId == model?.applied_category_id,
        );
        categoryName =
            category?.name.toString() ??
            widget.catalogScreenPassData[categoryNameKey];
      } else {
        categoryName =
            category?.name.toString() ??
            widget.catalogScreenPassData[categoryNameKey];
      }
    }

    isFilter = false;
    // setState(() {});
  }

  void postWishlistClick() {
    debugPrint("CatalogScreen hive update");
    //TODO : do nothing as of now, if the wishlisht callback and selctions gives error in future then will check from here
  }
}
