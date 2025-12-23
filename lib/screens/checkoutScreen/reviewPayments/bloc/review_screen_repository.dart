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

import 'dart:convert';

import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../../models/PaymentModel.dart';


abstract class PaymentReviewScreenRepository{
  Future<PaymentModel> getPaymentMethod();
  Future<OrderReviewModel> getOrderReviewData(int shippingAddressId, int acquirerId, int shippingId);
  Future<PlaceOrderModel> placeOrder(String paymentRefrence, int transactionId, String paymentStatus);
  Future<BaseModel> applyCouponCode(String coupon,);
  Future<BaseModel> removeCouponCode(int lineId);

}

class PaymentReviewScreenRepositoryImp implements PaymentReviewScreenRepository{
  @override
  Future<PaymentModel> getPaymentMethod() async{
    PaymentModel model;
    model = await ApiClient().getPaymentMethods();
    return model;
  }
  @override
  Future<BaseModel> removeCouponCode(int lineId) async{
    BaseModel? model;
    model = await ApiClient().removeCartItem(lineId);
    return model;
  }
  @override
  Future<OrderReviewModel> getOrderReviewData(int shippingAddressId, int acquirerId, int shippingId) async{
    OrderReviewModel model;
    Map<String, dynamic> data = {};
    data['shippingAddressId'] = shippingAddressId;
    data['acquirerId'] = acquirerId;
    data['shippingId'] = shippingId;
    String body = json.encode(data);
    model = await ApiClient().getOrderReviewData(body);
    return model;
}

  @override
  Future<PlaceOrderModel> placeOrder(String paymentRefrence, int transactionId, String paymentStatus) async{
    PlaceOrderModel model;
    Map<String, dynamic> data = {};
    data['paymentReference'] = paymentRefrence;
    data['transaction_id'] = transactionId;
    data['paymentStatus'] = paymentStatus;
    String body = json.encode(data);
    model = await ApiClient().placeOrder(body);
    return model;
  }
  @override
  Future<BaseModel> applyCouponCode(String coupon) async{
    BaseModel model;
    Map<String, dynamic> data = {};
    data['coupon'] = coupon;
    String body = json.encode(data);
    model = await ApiClient().applyCouponCode(body);
    return model;
  }
}