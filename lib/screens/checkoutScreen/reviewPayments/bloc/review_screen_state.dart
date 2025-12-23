/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';

abstract class PaymentReviewScreenState extends Equatable{
  const PaymentReviewScreenState();

  @override
  List<Object> get props => [];
}

class PaymentReviewScreenInitial extends PaymentReviewScreenState{}

class GetPaymentMethodSuccess extends PaymentReviewScreenState{
  PaymentModel? paymentModel;
  GetPaymentMethodSuccess(this.paymentModel);

  @override
  List<Object> get props => [];

}

class OrderReviewSuccess extends PaymentReviewScreenState{
  OrderReviewModel? orderReviewModel;
  OrderReviewSuccess(this.orderReviewModel);

  @override
  List<Object> get props => [];
}

class ApplyCouponCodeSuccessState extends PaymentReviewScreenState{
  BaseModel? baseModel;
  ApplyCouponCodeSuccessState(this.baseModel);

  @override
  List<Object> get props => [];
}
class RemoveCouponCodeSuccessState extends PaymentReviewScreenState{
  BaseModel? baseModel;
  RemoveCouponCodeSuccessState(this.baseModel);

  @override
  List<Object> get props => [];
}
class PlaceOrderSuccess extends PaymentReviewScreenState{
  PlaceOrderModel? placeOrderModel;
  PlaceOrderSuccess(this.placeOrderModel);

  @override
  List<Object> get props => [];
}


class PaymentReviewScreenError extends PaymentReviewScreenState{
  PaymentReviewScreenError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}
