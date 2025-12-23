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

import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../models/BaseModel.dart';



abstract class OrderDetailRepository {
  Future<OrderDetailModel> getOrderDetails(String orderEndpoint);
  Future<BaseModel> reOrderData(String id,bool mergeCart);
}

class OrderDetailRepositoryImp implements OrderDetailRepository {
  @override
  Future<OrderDetailModel> getOrderDetails(String orderEndPoint) async {
    try {
      OrderDetailModel? model;
      model = await ApiClient().orderDetails(orderEndPoint);
      return model;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
  @override
  Future<BaseModel> reOrderData(String id,bool mergeCart) async {
    try {
      BaseModel? model;
      Map<String, dynamic> data ={};
      data["needCartMerge"] = mergeCart;
      String body = json.encode(data);
      model = await ApiClient().reorderOrder(id, body);
      return model;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
