/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/cart/cart_screen.dart';
import 'package:flutter_project_structure/screens/cart/widgets/quantity_drop_down.dart';

import '../../../helper/app_shared_pref.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(this.product, this.localizations, this.bloc,
      {super.key});

  final Items? product;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.mediumPadding),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, productPage,
                  arguments: getProductDataMap(product?.name ?? '',
                      product?.templateId.toString() ?? ''))
              .then((value) {
            bloc?.add(const CartScreenDataFetchEvent());
            bloc?.emit(CartScreenInitial());
          });
        },
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: AppSizes.mediumPadding,
                    left: AppSizes.mediumPadding,
                    top: AppSizes.imageRadius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Image and qty dropdown
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ImageView(
                            url: product?.thumbNail,
                            height: AppSizes.height / 7,
                            width: AppSizes.width / 4,
                          ),
                          (product?.isEditable ?? false)
                              ? SizedBox(
                                  height: AppSizes.buttonRadius,
                                  child: QuantityDropDown((value) async {
                                    if (int.tryParse(value)! >
                                        (product?.qty?.toInt() ?? 1)) {}
                                    bloc?.add(SetCartItemQuantityEvent(
                                        product?.lineId ?? 0,
                                        int.tryParse(value) ?? 1));
                                    bloc?.emit(CartScreenInitial());
                                  }, product?.qty?.toInt()
                                      // product?.
                                      ),
                                )
                              : Text(
                                  "${localizations?.translate(AppStringConstant.qty)} ${product?.qty?.toInt().toString() ?? " "}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontSize: 14),
                                ),
                        ]),

                    const SizedBox(width: AppSizes.mediumPadding),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(product?.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.normal)),
                          const SizedBox(height: AppSizes.imageRadius),
                          Text(product?.priceUnit ?? "0.00",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: AppSizes.imageRadius),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                (localizations?.translate(
                                            AppStringConstant.subtotal) ??
                                        "") +
                                    ": ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontSize: 14),
                              ),
                              Expanded(
                                child: Text((product?.total ?? "0.00"),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Edit button
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.gray)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, productPage,
                                  arguments: getProductDataMap(
                                      product?.name ?? '',
                                      product?.templateId.toString() ?? ''))
                              .then((value) {
                            bloc?.add(const CartScreenDataFetchEvent());
                            bloc?.emit(CartScreenInitial());
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(AppSizes.imageRadius),
                          child: Icon(
                            Icons.edit,
                            size: AppSizes.iconButtonBorderRadius,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _iconButton(
                        Icons.favorite_border,
                        localizations
                                ?.translate(AppStringConstant.moveToWishlist) ??
                            "", () {
                      if (AppSharedPref().getIfLogin() != null &&
                          AppSharedPref().getIfLogin() == true) {
                        DialogHelper.confirmationDialog(
                            AppStringConstant.moveToWishlistText,
                            context,
                            localizations, onConfirm: () {
                          bloc?.add(CartToWishlistEvent(
                              product?.name ?? "", product?.lineId ?? 0));
                          bloc?.emit(CartScreenInitial());
                        });
                      } else {
                        DialogHelper.confirmationDialog(
                            "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                            context,
                            AppLocalizations.of(context), onConfirm: () async {
                          Navigator.pushNamed(context, loginSignup,
                              arguments: false);
                        });
                      }
                    }, context),
                    _iconButton(
                        Icons.delete_forever,
                        localizations
                                ?.translate(AppStringConstant.removeItem) ??
                            "", () {
                      DialogHelper.confirmationDialog(
                          AppStringConstant.deleteItemFromCart,
                          context,
                          localizations, onConfirm: () async {
                        bloc?.add(RemoveCartItem(product?.lineId ?? 0));
                        bloc?.emit(CartScreenInitial());
                        // AnalyticsEventsFirebase().removeFromCart(
                        //   product?.lineId.toString() ?? "0",
                        //   product?.name ?? "0",
                        // );
                      });
                    }, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, String title, VoidCallback onTap,
          BuildContext context) =>
      SizedBox(
        width: AppSizes.width / 2.2,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              side: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary, width: 1.5)),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(width: AppSizes.linePadding),
                Flexible(
                    child: Text(title.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onPrimary))),
              ],
            ),
          ),
        ),
      );
}
