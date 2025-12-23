import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../constants/route_constant.dart';
import '../../customWidgtes/app_bar.dart';
import '../../customWidgtes/badge_icon.dart';
import '../../customWidgtes/dialog_helper.dart';
import '../../customWidgtes/lottie_animation.dart';
import '../../helper/LocalDb/floor/database.dart';
import '../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../helper/LocalDb/floor/recent_view_controller.dart';
import '../../helper/alert_message.dart';
import '../../helper/app_localizations.dart';
import '../../helper/app_shared_pref.dart';
import '../../helper/image_view.dart';
import '../../helper/loader.dart';
import '../../models/BaseModel.dart';
import '../../models/compare_product_model.dart';
import 'bloc/compare_product_bloc.dart';
import 'bloc/compare_product_events.dart';
import 'bloc/compare_product_repository.dart';
import 'bloc/compare_product_state.dart';

class CompareProducts extends StatefulWidget {
  const CompareProducts({Key? key}) : super(key: key);

  @override
  _CompareProductsState createState() => _CompareProductsState();
}

class _CompareProductsState extends State<CompareProducts> {
  CompareProductModel compareProductModel = CompareProductModel();
  CompareProductBloc? _compareProductBloc;
  AppLocalizations? _localizations;
  bool isLoading = false;

  @override
  void initState() {
    _compareProductBloc = context.read<CompareProductBloc>();
    _compareProductBloc?.add(const CompareProductDataFetchEvent());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.compareProduct) ?? '',
            context,    actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, cart);
              },
              icon: BadgeIcon(
                icon: const Icon(Icons.shopping_cart),
              )),
        ]),

        body: BlocBuilder<CompareProductBloc, CompareProductState>(
            builder: (context, currentState) {
          if (currentState is CompareProductInitial) {
            isLoading = true;
          } else if (currentState is CompareProductSuccess) {
            isLoading = false;
            compareProductModel = currentState.model;
          } else if (currentState is AddToCartState) {
            isLoading = false;
            if (currentState.model?.success == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? "", context);
                Navigator.pop(context);
              });
            }
          } else if (currentState is CompareProductError) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.message ?? "", context);
              Navigator.pop(context);
            });
          }
          return _buildUI();
        }));
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
          visible: compareProductModel.productList != null,
          child: (compareProductModel.productList?.isNotEmpty ?? false)
              ? compareView(context)
              : lottieAnimation(
                  context,
                  _localizations?.translate(AppStringConstant.noItems) ?? "",
                  _localizations
                          ?.translate(AppStringConstant.noItemsInCompare) ??
                      "",
                  _localizations
                          ?.translate(AppStringConstant.continueShopping) ??
                      "",
                  () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(navBar, (route) => false,arguments: 0);
                  },
                  icon: Icons.compare,
                ),
        ),
        Visibility(visible: isLoading, child: Loader())
      ],
    );
  }

  Widget compareView(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: (AppSizes.width / 2.5) + 80,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: compareProductModel.productList?.length ?? 5,
                  itemBuilder: (context, index) {
                    return productDetails(
                        context,
                        compareProductModel.productList?[index],
                        _compareProductBloc!,
                        index);
                  }),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: (compareProductModel.attributeValueList ?? [])
                  .map((e) => productAttributes(context, e))
                  .toList(),
            ),
            if(compareProductModel.productList?.isNotEmpty ?? false)
            Padding(
              padding:  EdgeInsets.symmetric(vertical: AppSizes.extraPadding,horizontal: AppSizes.width/5.5),
              child: SizedBox(
                width: AppSizes.width/1.5,
                height: AppSizes.buttonHeight,
                child: ElevatedButton(
                    onPressed: () {
                      _compareProductBloc?.emit(CompareProductInitial());
                      List? compareData = AppSharedPref().getCompareData() ?? [];
                      compareData.clear();
                      AppSharedPref().setCompareData(compareData);
                      _compareProductBloc
                          ?.add(const CompareProductDataFetchEvent());
                      AlertMessage.showSuccess(
                          AppLocalizations.of(context)?.translate(
                              AppStringConstant.removeAllItemsInCompare) ??
                              "",
                          context);
                    },style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300), child: Text(AppLocalizations.of(context)?.translate(AppStringConstant.removeAllItems)?? "",style: const TextStyle(color: Colors.white),),),
              ),
            )
          ],
        ),
      ),
    );
  }

  productDetails(BuildContext context, ProductTileData? productData,
      CompareProductBloc compareProductBloc, int index,
      {Function? removeCallBack, Function? detailsCallBack}) {
    double imageSize = (AppSizes.width / 2.5) - AppSizes.linePadding;
    bool addedInWishlist = AppSharedPref()
            .getWishlistData()
            ?.contains(compareProductModel.productList?[index].id) ??
        false;

    return InkWell(
      onTap: () {
        AppDatabase.getDatabase().then(
              (value) => value.recentProductDao
              .insertRecentProduct(
            RecentProduct(
                templateId: productData?.templateId.toString() ?? '',
                name: productData?.name,
                priceUnit: productData?.priceUnit,
                priceReduce: productData?.priceReduce,
                image: productData?.thumbNail ?? '',
                productId: productData?.id ?? -1,
                productCount: productData?.productVarientCount ?? -1),
          )
              .then(
                (value) => RecentViewController.controller.sink
                .add(productData?.templateId?.toString() ?? ''),
          ),
        );
        Navigator.pushNamed(context, productPage,
            arguments: getProductDataMap(productData?.name ?? "",
                productData?.templateId.toString() ?? ''));
      },
      child: SizedBox(
        width: imageSize + 20,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  )),
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Center(
                      child: ImageView(
                        fit: BoxFit.fill,
                        url: productData?.thumbNail,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppSizes.imageRadius,
                        top: AppSizes.imageRadius,
                        right: AppSizes.imageRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(productData?.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: TextSizes.textSizeNormal)),
                            ),
                            const SizedBox(
                              width: AppSizes.normalPadding,
                            ),
                            InkWell(
                              onTap: () {
                                DialogHelper.loaderDialog(
                                    AppStringConstant.loadingMessage,
                                    AppStringConstant.addToCartDescription,
                                    context,
                                    AppLocalizations.of(context));
                                compareProductBloc.add(AddToCartEvent(
                                    productData?.id.toString() ?? "", "1"));
                                  // if ((productData?.productVarientCount ?? 0) > 1) {
                                  //   Navigator.of(context).pushNamed(productPage,
                                  //       arguments: getProductDataMap(
                                  //           productData?.name ?? '',
                                  //           productData?.templateId.toString() ?? '')).
                                  //   then((value){
                                  //     if(value==true) {
                                  //       setState(() {});
                                  //     }
                                  //   });
                                  // }
                                //   else if ((productData?.productVarientCount ?? 0) == 1) {
                                //     DialogHelper.loaderDialog(
                                //         AppStringConstant.loadingMessage,
                                //         AppStringConstant.addToCartDescription,
                                //         context,
                                //         AppLocalizations.of(context));
                                // compareProductBloc.add(AddToCartEvent(
                                //     productData?.id.toString() ?? "", "1"));
                                // }
                              },
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: AppSizes.linePadding,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                (productData?.priceReduce ?? '').isNotEmpty
                                    ? productData?.priceReduce ?? ''
                                    : productData?.priceUnit ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Visibility(
                              visible:
                                  (productData?.priceReduce ?? '').isNotEmpty,
                              child: const SizedBox(
                                width: 4.0,
                              ),
                            ),
                            Visibility(
                                visible:
                                    (productData?.priceReduce ?? '').isNotEmpty,
                                child: Text(
                                  productData?.priceUnit ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          decoration: TextDecoration.lineThrough),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: AppSizes.linePadding,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              left: 4,
              child: IconButton(
                icon: const Icon(Icons.cancel),
                color: Colors.grey[400],
                onPressed: () {
                  _compareProductBloc?.emit(CompareProductInitial());
                  List? compareData = AppSharedPref().getCompareData() ?? [];
                  compareData.remove(productData?.id);
                  AppSharedPref().setCompareData(compareData);
                  _compareProductBloc?.add(const CompareProductDataFetchEvent());
                  AlertMessage.showSuccess(
                      AppLocalizations.of(context)?.translate(
                              AppStringConstant.removeItemsInCompare) ??
                          "",
                      context);
                },
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: Icon(
                  (addedInWishlist)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: (addedInWishlist)
                      ? AppColors.lightRed
                      : AppColors.lightGray,
                  size: 22,
                ),
                color: Colors.grey[400],
                onPressed: () async {
                  DialogHelper.loaderDialog(AppStringConstant.loadingMessage, '',
                      context, AppLocalizations.of(context));
                  processWishlistClick(addedInWishlist, context, productData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productAttributes(
      BuildContext context, AttributeValue? productAttribute) {
    double imageSize = (AppSizes.width / 2.5) - AppSizes.linePadding;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: imageSize + 20,
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Text(productAttribute?.title ?? 'db',style: Theme.of(context).textTheme.titleSmall,)),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: (productAttribute?.attributeList ?? [])
              .map((e){
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: imageSize + 20,
                        padding: const EdgeInsets.all(AppSizes.imageRadius),
                        child: Text(e.attributeName ?? 'db',style: Theme.of(context).textTheme.bodyLarge,)),
                    IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: (e.value ?? [])
                              .map(
                                (e) => Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                width: imageSize + 20,
                                padding: const EdgeInsets.all(AppSizes.imageRadius),
                                child: Text(e)),
                          )
                              .toList()),
                    ),
                  ],
                );
          })
              .toList(),
        ),
      ],
    );
  }

  void processWishlistClick(
      bool isInWishlist, BuildContext context, ProductTileData? product) async {
    CompareProductRepository? repository = CompareProductRepositoryImp();
    List<int>? wishlistData = AppSharedPref().getWishlistData();
    try {
      BaseModel? model;
      if (!isInWishlist) {
        model = await repository.addToWishList(
            product?.id.toString() ?? "", product?.name ?? '');
        if (model?.success ?? false) {
          AlertMessage.showSuccess(model?.message ?? "", context);
          wishlistData!.add(product?.id ?? 0);
          AppSharedPref().setWishlistData(wishlistData);
        } else {
          AlertMessage.showError(model?.message ?? "", context);
        }
      } else {
        model =
            await repository.removeFromWishList(product?.id.toString() ?? "");
        if (model?.success ?? false) {
          AlertMessage.showSuccess(model?.message ?? "", context);
          wishlistData!.remove(product?.id ?? 0);
          AppSharedPref().setWishlistData(wishlistData);
        } else {
          AlertMessage.showError(model?.message ?? "", context);
        }
      }
    } catch (error, _) {
      debugPrint(error.toString());
      Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
    (context as Element).reassemble();
    Navigator.pop(context);
  }
}
