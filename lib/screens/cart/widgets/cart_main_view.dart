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
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/cart/widgets/price_details.dart';

import '../../../constants/arguments_map.dart';
import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_shared_pref.dart';
import '../../../models/BaseModel.dart';
import '../../../models/HomeScreenModel.dart';
import '../../product/bloc/product_screen_repository.dart';
import 'cart_icon_button.dart';
import 'cart_product_item.dart';

class CartMainView extends StatelessWidget {
  const CartMainView(this.model, this.localizations, this.bloc, {Key? key})
      : super(key: key);

  final CartViewModel? model;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // products list view
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.extraPadding),
              child: Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.imageRadius,
                          vertical: AppSizes.linePadding),
                      child: Text(
                          "${model?.cartCount} " +
                              (localizations?.translate(
                                          AppStringConstant.items) ??
                                      "")
                                  .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
            // Listview of products in cart
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) =>
                  CartProductItem(model?.items?[index], localizations, bloc),
              itemCount: (model?.items?.length ?? 0),
            ),
            if (AppSharedPref().getSplashData()?.isUpSelling ?? false)
              Visibility(
                visible: model?.accessoriesProducts?.isNotEmpty ?? false,
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              (localizations?.translate(
                                        AppStringConstant.suggestedItems,
                                      ) ??
                                      "")
                                  .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                        ),
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model?.accessoriesProducts?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: AppSizes.mediumPadding,
                                left: AppSizes.mediumPadding,
                                top: AppSizes.imageRadius),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, productPage,
                                        arguments: getProductDataMap(
                                            model?.accessoriesProducts?[index]
                                                    .name ??
                                                '',
                                            model?.accessoriesProducts?[index]
                                                    .templateId
                                                    .toString() ??
                                                ''))
                                    .then((value) {
                                  bloc?.add(const CartScreenDataFetchEvent());
                                  bloc?.emit(CartScreenInitial());
                                });
                              },
                              child: Row(
                                children: [
                                  ImageView(
                                    url: model
                                        ?.accessoriesProducts?[index].image,
                                    height: AppSizes.height / 7,
                                    width: AppSizes.width / 4,
                                  ),
                                  const SizedBox(width: AppSizes.mediumPadding),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          model?.accessoriesProducts?[index]
                                                  .name ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                      SizedBox(height: AppSizes.imageRadius),
                                      Text(
                                          model?.accessoriesProducts?[index]
                                                  .priceUnit ??
                                              "",

                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      SizedBox(height: AppSizes.imageRadius),
                                      OutlinedButton(
                                          onPressed: () {
                                            processAddToCartRequest(
                                                model?.accessoriesProducts?[
                                                    index],
                                                context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                width: 1.5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                                const SizedBox(
                                                    width:
                                                        AppSizes.linePadding),
                                                Text(
                                                    localizations?.translate(
                                                            AppStringConstant
                                                                .addToCart) ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary))
                                              ],
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
          ],
        ),

        CartIconButton(
          leadingIcon: Icons.remove_shopping_cart,
          title: (localizations?.translate(AppStringConstant.emptyCart) ?? "")
              .toUpperCase(),
          onClick: () {
            DialogHelper.confirmationDialog(
                AppStringConstant.emptyCartText, context, localizations,
                onConfirm: () {
              bloc?.add(SetCartEmpty());
              bloc?.emit(CartScreenInitial());
            });
          },
        ),
        const SizedBox(
          height: AppSizes.extraPadding,
        ),
        CartIconButton(
          leadingIcon: Icons.arrow_forward,
          title: localizations?.translate(AppStringConstant.continueShopping) ??
              "",
          onClick: () {
            Navigator.pushNamed(
              context,
              catalogPage,
              arguments: getCatalogMap("", false, "Shop Vegitables", customerId: 0),
            );
          },
        ),

        PriceDetails(
          totalProducts: model?.subtotal?.value,
          grandTotal: model?.grandtotal?.value,
          localizations: localizations,
          totalTax: model?.tax?.value,
        ),
      ],
    );
  }

  // void onTap(BuildContext context){
  //   if ((AppSharedPref().getIfLogin() != null &&
  //       AppSharedPref().getIfLogin() == true) ||
  //       AppSharedPref().getGuestCheckout()) {
  //     debugPrint("product!.productCount.toString --> " +
  //         widget.product!.productCount.toString());
  //
  //     if (widget.product!.productCount! > 1) {
  //       AppDatabase.getDatabase().then(
  //             (value) => value.recentProductDao
  //             .insertRecentProduct(
  //           RecentProduct(
  //               templateId: widget.product?.templateId
  //                   .toString() ??
  //                   '',
  //               name: widget.product?.name,
  //               priceUnit: widget.product?.priceUnit,
  //               priceReduce:
  //               widget.product?.priceReduce,
  //               image:
  //               widget.product?.thumbNail ?? '',
  //               productId:
  //               widget.product?.productId ?? -1,
  //               productCount:
  //               widget.product?.productCount ??
  //                   -1),
  //         )
  //             .then(
  //               (value) => RecentViewController
  //               .controller.sink
  //               .add(widget.product?.templateId
  //               ?.toString() ??
  //               ''),
  //         ),
  //       );
  //
  //       Navigator.of(context)
  //           .pushNamed(productPage,
  //           arguments: getProductDataMap(
  //               widget.product?.name ?? '',
  //               widget.product?.templateId
  //                   .toString() ??
  //                   ''))
  //           .then((value) {
  //         if (value == true) {
  //           widget.postWishlistClick();
  //         }
  //       });
  //     } else if (widget.product!.productCount! == 1) {
  //       DialogHelper.loaderDialog(
  //           AppStringConstant.loadingMessage,
  //           AppStringConstant.addToCartDescription,
  //           context,
  //           AppLocalizations.of(context));
  //       processAddToCartRequest(widget.product, context);
  //     }
  //   } else {
  //     DialogHelper.confirmationDialog(
  //         "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
  //         context,
  //         AppLocalizations.of(context),
  //         onConfirm: () async {
  //           Navigator.pushNamed(context, loginSignup,
  //               arguments: false);
  //         });
  //   }
  // }
  void processAddToCartRequest(
      Accessories? product, BuildContext context) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    try {
      // BaseModel model =
      //     await repository.addTocart(product!.productId!.toString(), 1);
      // if (model.success!) {
      //   bloc?.emit(CartScreenInitial());
      //
      //   AlertMessage.showSuccess(model.message!, context);
      //   AppSharedPref().setGuestCartCount(model.cartCount ?? 0);
      // } else {
      //   AlertMessage.showError(model.message!, context);
      // }
      bloc?.add(AddToCartEvent(product?.productId ?? 0));

      Navigator.pop(context);
    } catch (error, _) {
      debugPrint(error.toString());
      Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
  }
}
