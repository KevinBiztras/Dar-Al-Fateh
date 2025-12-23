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
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_order_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';
import 'package:flutter_project_structure/screens/cart/widgets/price_details.dart';
import 'package:flutter_project_structure/screens/checkoutScreen/reviewPayments/widgets/place_order_screen.dart';

import '../../../constants/app_constants.dart';
import '../../../customWidgtes/common_outlined_button.dart';
import '../../../customWidgtes/common_text_field.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_shared_pref.dart';
import '../shippingDetails/views/checkout_progress_line.dart';
import '../shippingDetails/views/shipping_methods_view.dart';
import 'bloc/review_screen_bloc.dart';
import 'bloc/review_screen_event.dart';
import 'bloc/review_screen_state.dart';
import 'widgets/order_summary.dart';

class ReviewScreen extends StatefulWidget {
  Map<String, dynamic> args;

  ReviewScreen(this.args, {Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  AppLocalizations? _localizations;
  bool isAddressSame = false;
  bool isLoading = true;
  PaymentModel? paymentModel;
  OrderReviewModel? orderReviewModel;
  PaymentReviewScreenBloc? paymentReviewScreenBloc;
  PlaceOrderModel? placeOrderModel;
  int selectedPaymentMethodIndex = 0;
  TextEditingController applyCouponController = TextEditingController();

  @override
  void initState() {
    paymentReviewScreenBloc = context.read<PaymentReviewScreenBloc>();
    paymentReviewScreenBloc?.add(GetPaymentMethodEvent());
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
        appBar: commonToolBar(
            _localizations?.translate(AppStringConstant.reviewPayments) ?? "",
            context),
        body: BlocBuilder<PaymentReviewScreenBloc, PaymentReviewScreenState>(
            builder: (context, currentState) {
          if (currentState is PaymentReviewScreenInitial) {
            isLoading = true;
          } else if (currentState is GetPaymentMethodSuccess) {
            isLoading = true;
            paymentModel = currentState.paymentModel;
            paymentReviewScreenBloc?.add(OrderReviewEvent(
                widget.args[shippingAddressIdKey],
                paymentModel?.acquirers?[0].id ?? 0,
                widget.args[shippingIdKey]));
            paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
          } else if (currentState is OrderReviewSuccess) {
            isLoading = false;
            if (currentState.orderReviewModel?.success == true) {
              orderReviewModel = currentState.orderReviewModel;
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.orderReviewModel?.message ?? '', context);
              });
            }
          } else if (currentState is ApplyCouponCodeSuccessState) {
            isLoading = false;
            if (currentState.baseModel?.success == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.baseModel?.message ?? '', context);
              });
              paymentReviewScreenBloc?.add(OrderReviewEvent(
                  widget.args[shippingAddressIdKey],
                  paymentModel?.acquirers?[0].id ?? 0,
                  widget.args[shippingIdKey]));
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.baseModel?.message ?? '', context);
              });
            }
          } else if (currentState is RemoveCouponCodeSuccessState) {
            isLoading = false;
            if (currentState.baseModel?.success == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.baseModel?.message ?? '', context);
              });
              paymentReviewScreenBloc?.add(OrderReviewEvent(
                  widget.args[shippingAddressIdKey],
                  paymentModel?.acquirers?[0].id ?? 0,
                  widget.args[shippingIdKey]));
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.baseModel?.message ?? '', context);
              });
            }
          } else if (currentState is PlaceOrderSuccess) {
            isLoading = false;
            placeOrderModel = currentState.placeOrderModel;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (placeOrderModel?.success ?? false) {
                AppSharedPref().setHasDefaultShipping(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlaceOrderScreen(placeOrderModel)));
              } else if (placeOrderModel?.cartCount == 0) {
                AlertMessage.showError(placeOrderModel?.message ?? '', context);
                Navigator.pushNamedAndRemoveUntil(
                    context, navBar, (route) => false,
                    arguments: 0);
              }
            });
          } else if (currentState is PaymentReviewScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }
          return _buildUI();
        }));
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
          visible: orderReviewModel?.success ?? false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkoutProgressLine(false, context),
                      showBillingAddress(
                          context, AppStringConstant.billingAddress),
                      shippinginfo(AppStringConstant.shippingInfo),
                      shippingMethod(),
                      paymentMethod(),
                      orderSummary(
                          context,
                          _localizations,
                          orderReviewModel?.items ?? [],
                          paymentReviewScreenBloc),
                      if (AppSharedPref().getSplashData()?.couponsProgram ??
                          false)
                        couponCode(),
                      PriceDetails(
                        grandTotal: orderReviewModel?.grandtotal?.value ?? "",
                        localizations: _localizations,
                        totalTax: orderReviewModel?.tax?.value,
                        totalProducts: orderReviewModel?.subtotal?.value,
                      )
                    ],
                  ),
                ),
              ),
              commonOrderButton(context, _localizations,
                  orderReviewModel?.grandtotal?.value ?? "", () {
                paymentReviewScreenBloc?.add(PlaceOrderEvent(
                    "", orderReviewModel?.transactionId ?? 0, ""));
                paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
              }, color: AppColors.success, title: AppStringConstant.placeOrder)
            ],
          ),
        ),
        Visibility(visible: isLoading, child: Loader())
      ],
    );
  }

  Widget showBillingAddress(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.imageRadius),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.linePadding,
                  horizontal: AppSizes.imageRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (_localizations?.translate(title) ?? '').toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.lightGray),
                  ),
                  SizedBox(
                    // height: 20,
                    // width: 60,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          shape: const StadiumBorder()),
                      onPressed: () {
                        Navigator.pushNamed(context, addEditAddress,
                                arguments: widget.args[addressEndpointKey])
                            .then((value) {
                          if (value == true) {
                            paymentReviewScreenBloc
                                ?.add(GetPaymentMethodEvent());
                            paymentReviewScreenBloc
                                ?.emit(PaymentReviewScreenInitial());
                          }
                        });
                      },
                      child: Text(
                        (_localizations?.translate(AppStringConstant.edit) ??
                                "EDIT")
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12, color: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            addressItemCard(
              orderReviewModel?.billingAddress ?? "",
              context,
            )
          ],
        ),
      ),
    );
  }

  Widget shippinginfo(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.mediumPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                _localizations?.translate(title) ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.imageRadius,
                  left: AppSizes.imageRadius,
                  right: AppSizes.imageRadius),
              child: Text(
                _localizations
                        ?.translate(AppStringConstant.shippingAddress)
                        .toUpperCase() ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            addressItemCard(orderReviewModel?.shippingAddress ?? '', context),
          ],
        ),
      ),
    );
  }

  Widget shippingMethod() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.mediumPadding),
      child: Container(
        width: AppSizes.width,
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                _localizations
                        ?.translate(AppStringConstant.shippingMethod)
                        .toUpperCase() ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(
                AppSizes.imageRadius,
              ),
              child: Text(
                orderReviewModel?.delivery?.name ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.imageRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                _localizations?.translate(AppStringConstant.paymentMethods) ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.lightGray),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ShippingMethodsView(
              paymentMethods: paymentModel?.acquirers,
              callBack: (index) {
                selectedPaymentMethodIndex = index;
              },
              paymentcallback: (index) {
                // debugPrint("payment --->" + index.toString());
                selectedPaymentMethodIndex = index;
                paymentReviewScreenBloc?.add(OrderReviewEvent(
                    widget.args[shippingAddressIdKey],
                    paymentModel?.acquirers?[selectedPaymentMethodIndex].id ??
                        0,
                    widget.args[shippingIdKey]));
                paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
              },
              selectedPaymentIndex: selectedPaymentMethodIndex,
            )
          ],
        ),
      ),
    );
  }

  Widget couponCode() {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: AppSizes.imageRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Text(
              _localizations
                      ?.translate(AppStringConstant.couponCode)
                      .toUpperCase() ??
                  "",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.lightGray),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: CommonTextField(
                    hintText: _localizations
                            ?.translate(AppStringConstant.couponCode) ??
                        "",
                    controller: applyCouponController,
                    isRequired: true,
                    isPassword: false,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                    flex: 1,
                    child: commonButton(
                        height: AppSizes.buttonHeight + 8, context, () {
                      if (applyCouponController.text.isNotEmpty) {
                        paymentReviewScreenBloc?.add(
                            ApplyCouponCodeEvent(applyCouponController.text));
                        paymentReviewScreenBloc
                            ?.emit(PaymentReviewScreenInitial());
                        applyCouponController.text = "";
                      } else {
                        AlertMessage.showWarning(
                            _localizations?.translate(
                                    AppStringConstant.couponCodeWarningMsg) ??
                                "",
                            context);
                      }
                    },
                        (_localizations?.translate(AppStringConstant.apply) ??
                                "")
                            .toUpperCase(),
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        borderRadius: 0,
                        textColor:
                            Theme.of(context).colorScheme.secondaryContainer))
              ],
            ),
          ),
          if (orderReviewModel?.appliedCoupons?.isNotEmpty ?? false)
            Container(
              color: Colors.greenAccent.shade100,
              padding: const EdgeInsets.all(AppSizes.imageRadius),
              margin: const EdgeInsets.all(AppSizes.imageRadius),
              child: Text(
                "${_localizations?.translate(AppStringConstant.applyCouponCode) ?? ""} ${orderReviewModel?.appliedCoupons?.join(', ')}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.green,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  void billingAddress(bool isOn) {
    setState(() {
      isAddressSame = isOn;
      isAddressSame = !isAddressSame;
    });
  }
}
