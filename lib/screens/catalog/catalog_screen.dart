

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

class CatalogScreen extends StatefulWidget {
  final Map<String, dynamic> catalogScreenPassData;

  CatalogScreen(this.catalogScreenPassData);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
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

  // Animation controller for subtle header appearance
  late AnimationController _headerAnimController;
  late Animation<double> _headerFadeAnim;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    _headerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _headerFadeAnim = CurvedAnimation(
      parent: _headerAnimController,
      curve: Curves.easeOut,
    );
    _headerAnimController.forward();

    catalogScreenBloc = context.read<CatalogScreenBloc>();

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
    _headerAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (productList.isEmpty) {
      for (int i = 0; i < 10; i++) {
        productList.add(
          Products(
            name: 'Demo Product ${i + 1}',
            priceUnit: "\$${(i + 1) * 25}.99",
            productId: i,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF111318)
          : const Color(0xFFF7F8FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 64),
        child: _buildAppBar(isDark, colorScheme),
      ),
      body: BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
        builder: (context, state) {
          if (state is CatalogScreenInitialState) {
            if (!isFromPagination) isLoading = true;
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
              WidgetsBinding.instance.addPostFrameCallback((_) => AppBarName());
            }
          } else if (state is CatalogScreenErrorState) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(state.message ?? '', context);
            });
          }

          return Stack(
            children: [
              Visibility(
                visible: model?.products?.isNotEmpty ?? true,
                child: RefreshIndicator(
                  color: colorScheme.primary,
                  strokeWidth: 2.5,
                  onRefresh: () async {
                    isFromPagination = false;
                    offset = 0;
                    setState(() => isLoading = true);
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
                      ..addListener(() => paginationFunction()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
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
                          if (isFromPagination)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Center(
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: colorScheme.onSurface.withOpacity(0.25),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _localizations?.translate(
                              AppStringConstant.noProductFound,
                            ) ??
                            'No products found',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.45),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(bool isDark, ColorScheme colorScheme) {
    return FadeTransition(
      opacity: _headerFadeAnim,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1F26) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        categoryName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                          color: colorScheme.onSurface,
                          fontSize: 23,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _AppBarIconBtn(
                      icon: Icons.search_rounded,
                      onTap: () => Navigator.pushNamed(context, searchPage),
                    ),
                  ],
                ),
              ),
              // Filter / Sort / View toggle row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  children: [
                    _ToolbarChip(
                      icon: Icons.tune_rounded,
                      label:
                          _localizations?.translate(AppStringConstant.filter) ??
                          'Filter',
                      onTap: () {
                        List<dynamic> attributeValue = [];
                        for (var item in model?.applied_filters ?? []) {
                          List<AppliedFiltersValue> appliedFiltersValue =
                              item.applied_filters_value ?? [];
                          if (appliedFiltersValue.isNotEmpty) {
                            for (var attr in appliedFiltersValue) {
                              if (!attributeValue.contains([
                                item.id,
                                attr.id,
                              ])) {
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
                            setState(() => isLoading = true);
                            catalogScreenBloc?.add(
                              FilterFetchDataEvent(
                                value as Map<String, dynamic>,
                              ),
                            );
                            setState(() => isFilter = true);
                          }
                        });
                      },
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    _ToolbarChip(
                      icon: Icons.sort_rounded,
                      label:
                          _localizations?.translate(AppStringConstant.sort) ??
                          'Sort',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          catalogSortPage,
                          arguments: selectedSorting ?? "",
                        ).then((value) {
                          if (value != null) {
                            productList.clear();
                            offset = 0;
                            setState(() => isLoading = true);
                            catalogScreenBloc?.add(
                              CatalogScreenDataFetchEvent(
                                widget.catalogScreenPassData[customerIdKey],
                                10,
                                offset,
                                value as String,
                              ),
                            );
                            setState(() => selectedSorting = value as String);
                          }
                        });
                      },
                      isDark: isDark,
                    ),
                    const Spacer(),
                    // Grid / List toggle
                    _ViewToggle(
                      isGrid: isGridViewShowing,
                      isDark: isDark,
                      onToggle: () {
                        setState(() => isGridViewShowing = !isGridViewShowing);
                        buildScreen?.sink.add(isGridViewShowing);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listView(List<Products> productList) {
    print('List Callback--${productList.length}');
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ProductItemFullWidth(
            product: productList[index],
            onAddToCart: addToCart,
          ),
        );
      },
    );
  }

  void paginationFunction() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (model?.tcount ?? 0) != productList.length) {
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
        setState(() => isLoading = true);
      }
    }
  }

  void addToCart(Products product, [int quantity = 1]) async {
    CartScreenBloc? cartBloc;
    try {
      cartBloc = context.read<CartScreenBloc>();
    } catch (e) {
      cartBloc = null;
    }

    if (cartBloc != null) {
      cartBloc.add(AddToCartEvent(product.productId ?? 0));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${product.name} added to cart')));
      try {
        final state = await cartBloc.stream.firstWhere(
          (s) => s is AddToCartItemSuccess || s is CartScreenError,
        );
        if (state is AddToCartItemSuccess) {
          AlertMessage.showSuccess(state.data.message ?? '', context);
          cartBloc.add(const CartScreenDataFetchEvent());
        } else if (state is CartScreenError) {
          AlertMessage.showError(state.message ?? '', context);
        }
      } catch (_) {
        print('Add to cart: no response from CartBloc');
      }
      return;
    }

    try {
      final repository = ProductScreenRepositoryImp();
      final model = await repository.addTocart(
        product.productId!.toString(),
        quantity,
      );
      if (model.success ?? false) {
        AlertMessage.showSuccess(model.message ?? '', context);
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
  }

  void postWishlistClick() {
    debugPrint("CatalogScreen hive update");
  }
}

// ─── Small reusable sub-widgets ──────────────────────────────────────────────

class _AppBarIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _AppBarIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.07)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _ToolbarChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;
  const _ToolbarChip({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.07)
              : colorScheme.primary.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.12)
                : colorScheme.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: colorScheme.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewToggle extends StatelessWidget {
  final bool isGrid;
  final bool isDark;
  final VoidCallback onToggle;
  const _ViewToggle({
    required this.isGrid,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.07)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
          size: 20,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
