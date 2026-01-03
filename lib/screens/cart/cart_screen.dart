import 'package:flutter/cupertino.dart';
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
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_order_button.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/cart/widgets/cart_main_view.dart';

import '../../constants/route_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  CartViewModel? cartViewModel;
  CartScreenBloc? cartScreenBloc;
  BaseModel? baseModel;

  @override
  void initState() {
    cartScreenBloc = context.read<CartScreenBloc>();
    Future.delayed(Duration.zero, () {
      loginCheck();
    });
    super.initState();
  }

  loginCheck() {
    if ((AppSharedPref().getIfLogin() != null &&
            AppSharedPref().getIfLogin() == true) ||
        AppSharedPref().getGuestCheckout()) {
      cartScreenBloc?.add(const CartScreenDataFetchEvent());
    } else {
      //     DialogHelper.confirmationDialog(
      //     "${_localizations?.translate(AppStringConstant.signInToContinue)}",
      //     context,
      //     _localizations, onConfirm: () {
      //   Navigator.pushNamed(context, loginSignup, arguments: false)
      //       .then((value) {
      //     if (value == true) {
      //       cartScreenBloc?.add(const CartScreenDataFetchEvent());
      //     } else {
      //       Navigator.pushNamedAndRemoveUntil(context, navBar, (route) => false,
      //           arguments: 0);
      //     }
      //   });
      // }, onCancel: () {
      //   Navigator.pushNamedAndRemoveUntil(context, navBar, (route) => false,
      //       arguments: 0);
      // });
      AppSharedPref().setGuestCheckout(true);
      cartScreenBloc?.add(const CartScreenDataFetchEvent());
    }
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
          _localizations?.translate(AppStringConstant.cart) ?? "", context,
          actions: [
            if (AppSharedPref().getIfLogin() != null &&
                AppSharedPref().getIfLogin() == true)
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, wishlist).then((value) {
                      cartScreenBloc?.add(const CartScreenDataFetchEvent());
                      cartScreenBloc?.emit(CartScreenInitial());
                    });
                  },
                  child: Text(
                    (_localizations
                                ?.translate(AppStringConstant.gotoWishlist) ??
                            "")
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).appBarTheme.iconTheme?.color),
                  ))
          ]),
      body: SafeArea(
        child: BlocBuilder<CartScreenBloc, CartScreenState>(
          builder: (context, state) {
            if (state is CartScreenInitial) {
              isLoading = true;
            } else if (state is AddToCartItemSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.data.message!, context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is CartScreenSuccess) {
              isLoading = false;
              cartViewModel = state.model;
              var model = AppSharedPref().getUserData();
              model?.cartCount = cartViewModel?.cartCount;
              AppSharedPref().setUserData(model);
            } else if (state is RemoveCartItemSuccess) {
              // isLoading = false;
              baseModel = state.data;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.data.message ?? '', context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is CartToWishlistState) {
              isLoading = false;
              baseModel = state.data;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.data.message ?? '', context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is SetCartEmptyState) {
              isLoading = false;
              baseModel = state.data;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.data.message ?? '', context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is SetCartItemQtyState) {
              isLoading = false;
              baseModel = state.data;
              if (state.data.success ?? false) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AlertMessage.showSuccess(state.data.message ?? '', context);
                });
                cartScreenBloc?.add(const CartScreenDataFetchEvent());
                cartScreenBloc?.emit(CartScreenInitial());
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AlertMessage.showError(state.data.message ?? '', context);
                });
              }
            } else if (state is CartScreenError) {
              isLoading = false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AlertMessage.showError(state.message ?? '', context);
              });
            }
            return _buildUI();
          },
        ),
      ),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: (cartViewModel != null),
          child: cartViewModel?.cartCount == 0 ||
                  (cartViewModel?.items ?? []).isEmpty
              ? lottieAnimation(
                  context,
                  (_localizations?.translate(AppStringConstant.emptyCart) ?? "")
                      .toUpperCase(),
                  _localizations?.translate(AppStringConstant.noItemsInCart) ??
                      "",
                  _localizations
                          ?.translate(AppStringConstant.continueShopping) ??
                      "",
                  () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        navBar, (route) => false,
                        arguments: 0);
                  },
                  lottiePath: (Theme.of(context).brightness == Brightness.light)
                      ? "lib/assets/lottie/empty_cart.json"
                      : "lib/assets/lottie/empty_cart_dark.json",
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child:
                         CartMainView(
                            cartViewModel, _localizations, cartScreenBloc),
                      ),
                    ),
                    commonOrderButton(context, _localizations,
                        cartViewModel?.grandtotal?.value.toString() ?? "", () {
                       if (AppSharedPref().getHasDefaultShipping() ==
                              false &&
                          AppSharedPref().getGuestCheckout() &&
                          !(AppSharedPref().getIfLogin() != null &&
                              (AppSharedPref().getIfLogin() ?? false))) {
                         if (AppSharedPref().getSplashData()?.redirectToLogin ??
                             false) {
                           Navigator.pushReplacementNamed(context, loginSignup,
                               arguments: true);
                         } else {
                           Navigator.of(context).pushNamed(guestCheckoutScreen,
                               arguments: cartViewModel);
                         }
                      } else {
                        Navigator.of(context).pushNamed(checkoutPage,
                            arguments: cartViewModel?.grandtotal?.value);
                      }
                    }, color: Theme.of(context).colorScheme.onPrimary)
                  ],
                ),
        ),
        Visibility(
          visible: isLoading,
          child: Loader(),
        ),
      ],
    );
  }
}
