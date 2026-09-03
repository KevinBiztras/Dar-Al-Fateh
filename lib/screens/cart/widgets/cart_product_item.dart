
// ============ cart_product_item.dart ============
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

const Color _emerald = Color(0xFF1B5E20);
const Color _leafGreen = Color(0xFF2E7D32);
const Color _sage = Color(0xFFB7C9A8);
const Color _gold = Color(0xFFF9A825);

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _sage),
        color: Colors.white,
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
              vertical: 6,
            ),
            child: Text(
              _quantity.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: _emerald,
              ),
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
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: _emerald,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.mediumPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(AppSizes.mediumPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: ImageView(
                      url: widget.product?.thumbNail,
                      height: AppSizes.height / 7,
                      width: AppSizes.width / 4,
                    ),
                  ),
                  const SizedBox(width: AppSizes.mediumPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          widget.product?.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              (widget.product?.priceReduce ?? '').isNotEmpty
                                  ? (widget.product?.priceReduce ?? "0.00")
                                  : (widget.product?.priceUnit ?? "0.00"),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _leafGreen,
                              ),
                            ),
                            if ((widget.product?.priceReduce ?? '').isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  widget.product?.priceUnit ?? "0.00",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              "${widget.localizations?.translate(AppStringConstant.subtotal) ?? ""}: ",
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontSize: 12.5,
                                    color: Colors.grey[600],
                                  ),
                            ),
                            Expanded(
                              child: Text(
                                (widget.product?.total ?? "0.00"),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        (widget.product?.isEditable ?? false)
                            ? _quantityControl(context)
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _sage.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${widget.localizations?.translate(AppStringConstant.qty)} ${widget.product?.qty?.toInt().toString() ?? " "}",
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: _emerald,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: _sage.withOpacity(0.3)),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _iconButton(
                    Icons.favorite_border_rounded,
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
                    buttonColor: const Color(0xFFEFF4EA),
                    borderColor: const Color(0xFFEFF4EA),
                    iconColor: _leafGreen,
                  ),
                  _iconButton(
                    Icons.delete_outline_rounded,
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
                        },
                      );
                    },
                    context,
                    iconColor: const Color(0xFFD32F2F),
                    borderColor: const Color(0xFFFCEBEA),
                    buttonColor: const Color(0xFFFCEBEA),
                  ),
                ],
              ),
            ),
          ],
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
  }) => Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              buttonColor ?? Theme.of(context).colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.onPrimary,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                    color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
