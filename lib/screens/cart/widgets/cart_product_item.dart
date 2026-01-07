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
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';

import '../../../helper/app_shared_pref.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem(
    this.product,
    this.localizations,
    this.bloc, {
    super.key,
  });

  final Items? product;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.product?.qty?.toInt() ?? 1;
  }

  @override
  void didUpdateWidget(covariant CartProductItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    final int newQty = widget.product?.qty?.toInt() ?? 1;
    if (newQty != _quantity) {
      _quantity = newQty;
    }
  }

  void _updateQuantity(int nextQty) {
    if (nextQty < 1) {
      return;
    }
    setState(() {
      _quantity = nextQty;
    });
    widget.bloc?.add(
      SetCartItemQuantityEvent(widget.product?.lineId ?? 0, nextQty),
    );
    widget.bloc?.emit(CartScreenInitial());
  }

  Widget _quantityControl(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.linePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        border: Border.all(color: Theme.of(context).dividerColor),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _quantityButton(
            context,
            icon: Icons.remove,
            onTap: () => _updateQuantity(_quantity - 1),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.genericPadding,
              vertical: AppSizes.linePadding,
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: Text(
              _quantity.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _quantityButton(
            context,
            icon: Icons.add,
            onTap: () => _updateQuantity(_quantity + 1),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.linePadding,
          vertical: 2,
        ),
        child: Icon(icon, size: 18, color: Theme.of(context).iconTheme.color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.mediumPadding),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            productPage,
            arguments: getProductDataMap(
              widget.product?.name ?? '',
              widget.product?.templateId.toString() ?? '',
            ),
          ).then((value) {
            widget.bloc?.add(const CartScreenDataFetchEvent());
            widget.bloc?.emit(CartScreenInitial());
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
                  top: AppSizes.imageRadius,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ImageView(
                          url: widget.product?.thumbNail,
                          height: AppSizes.height / 7,
                          width: AppSizes.width / 4,
                        ),
                      ],
                    ),

                    const SizedBox(width: AppSizes.mediumPadding),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            widget.product?.name ?? "",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: AppSizes.imageRadius),
                          Row(
                            children: [
                              Text(
                                "Price: ",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(fontSize: 14),
                              ),
                              Text(
                                (widget.product?.priceReduce ?? '').isNotEmpty
                                    ? (widget.product?.priceReduce ?? "0.00")
                                    : (widget.product?.priceUnit ?? "0.00"),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if ((widget.product?.priceReduce ?? '').isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: AppSizes.linePadding,
                                  ),
                                  child: Text(
                                    widget.product?.priceUnit ?? "0.00",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.imageRadius),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "${widget.localizations?.translate(AppStringConstant.subtotal) ?? ""}: ",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(fontSize: 14),
                              ),
                              Expanded(
                                child: Text(
                                  (widget.product?.total ?? "0.00"),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Quantity Control
                    (widget.product?.isEditable ?? false)
                        ? _quantityControl(context)
                        : Text(
                            "${widget.localizations?.translate(AppStringConstant.qty)} ${widget.product?.qty?.toInt().toString() ?? " "}",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(fontSize: 14),
                          ),

                    // Edit button
                    // Container(
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: AppColors.gray)),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.pushNamed(context, productPage,
                    //               arguments: getProductDataMap(
                    //                   product?.name ?? '',
                    //                   product?.templateId.toString() ?? ''))
                    //           .then((value) {
                    //         bloc?.add(const CartScreenDataFetchEvent());
                    //         bloc?.emit(CartScreenInitial());
                    //       });
                    //     },
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(AppSizes.imageRadius),
                    //       child: Icon(
                    //         Icons.edit,
                    //         size: AppSizes.iconButtonBorderRadius,
                    //       ),
                    //     ),
                    //   ),
                    // )
                    //----------------------------
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _iconButton(
                      // Icons.favorite_border,
                      Icons.arrow_forward,
                      widget.localizations?.translate(
                            AppStringConstant.moveToWishlist,
                          ) ??
                          "",
                      () {
                        AppSharedPref().setGuestCheckout(true);
                        DialogHelper.confirmationDialog(
                          AppStringConstant.moveToWishlistText,
                          context,
                          widget.localizations,
                          onConfirm: () {
                            widget.bloc?.add(
                              CartToWishlistEvent(
                                widget.product?.name ?? "",
                                widget.product?.lineId ?? 0,
                                templateId: widget.product?.templateId,
                              ),
                            );
                            widget.bloc?.emit(CartScreenInitial());
                          },
                        );
                      },
                      context,
                      buttonColor: Colors.grey.shade100,
                      borderColor: Colors.grey.shade100,
                      iconColor: Colors.blue.shade800,
                    ),
                    _iconButton(
                      Icons.delete_forever,

                      widget.localizations?.translate(
                            AppStringConstant.removeItem,
                          ) ??
                          "",
                      () {
                        DialogHelper.confirmationDialog(
                          AppStringConstant.deleteItemFromCart,
                          context,
                          widget.localizations,
                          onConfirm: () async {
                            widget.bloc?.add(
                              RemoveCartItem(widget.product?.lineId ?? 0),
                            );
                            widget.bloc?.emit(CartScreenInitial());
                            // AnalyticsEventsFirebase().removeFromCart(
                            //   product?.lineId.toString() ?? "0",
                            //   product?.name ?? "0",
                            // );
                          },
                        );
                      },
                      context,
                      iconColor: Colors.red,
                      borderColor: Colors.grey.shade100,
                      buttonColor: Colors.grey.shade100,
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
    IconData icon,
    String title,
    VoidCallback onTap,
    BuildContext context, {
    Color? iconColor,
    Color? buttonColor,
    Color? borderColor,
  }) => SizedBox(
    width: AppSizes.width / 2.2,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            buttonColor ??
            Theme.of(
              context,
            ).colorScheme.secondaryContainer, // Button background color
        side: BorderSide(
          color:
              borderColor ??
              Theme.of(context).colorScheme.onPrimary, // Border color
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.imageRadius),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(width: AppSizes.linePadding),
            Flexible(
              child: Text(
                title.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color:
                      iconColor ??
                      Theme.of(context).colorScheme.onPrimary, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
