

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
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';

class AddToCartButtonView extends StatelessWidget {
  AppLocalizations? _localizations;
  ProductScreenBloc? productPageBloc;
  int productId;
  int counter;
  String productName;
  final ValueChanged<bool>? callback;

  AddToCartButtonView(
    this.productPageBloc,
    this.productId,
    this.productName,
    this.counter, {
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
      color: theme.cardColor,
      child: Row(
        children: [
          // ADD TO CART — outlined style
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _handleAddToCart(context),
              icon: Icon(Icons.shopping_cart_outlined, size: 18),
              label: Text(
                _localizations?.translate(AppStringConstant.addToCart) ??
                    'Add to Cart',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.onPrimary,
                side: BorderSide(
                  color: theme.colorScheme.onPrimary,
                  width: 1.5,
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          // BUY NOW — filled style
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _handleBuyNow(context),
              icon: Icon(Icons.flash_on_rounded, size: 18),
              label: Text(
                _localizations?.translate(AppStringConstant.buyNow) ??
                    'Buy Now',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
                foregroundColor: theme.colorScheme.secondaryContainer,
                padding: EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddToCart(BuildContext context) {
    final isLoggedIn = AppSharedPref().getIfLogin() == true;
    if (isLoggedIn || AppSharedPref().getGuestCheckout()) {
      productPageBloc?.add(AddtoCartEvent(productId.toString(), counter));
      productPageBloc?.emit(ProductScreenInitial());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Added to cart'),
            ],
          ),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      AppSharedPref().setGuestCheckout(true);
      productPageBloc?.add(AddtoCartEvent(productId.toString(), counter));
      productPageBloc?.emit(ProductScreenInitial());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Added to cart'),
            ],
          ),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleBuyNow(BuildContext context) {
    final _localizations = AppLocalizations.of(context);
    final isLoggedIn = AppSharedPref().getIfLogin() == true;
    if (isLoggedIn || AppSharedPref().getGuestCheckout()) {
      productPageBloc?.add(BuyNowEvent(productId.toString(), counter));
      productPageBloc?.emit(ProductScreenInitial());
    } else {
      DialogHelper.confirmationDialog(
        "${_localizations?.translate(AppStringConstant.signInToContinue)}",
        context,
        _localizations,
        onConfirm: () async {
          Navigator.pushNamed(context, loginSignup, arguments: false);
        },
      );
    }
  }
}
