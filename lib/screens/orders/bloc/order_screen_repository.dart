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
import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class OrderScreenRepository{
  Future<OrderModel> getOrderList(int offset, int limit);
  Future<OrderDetailModel> getOrderDetails(String url);
  Future<BaseModel> reOrderData(String id,bool mergeCart);

}

class OrderScreenRepositoryImp implements OrderScreenRepository{

  @override
  Future<OrderModel> getOrderList(int offset, int limit) async{
    OrderModel? model;
    Map<String,dynamic> data = {};
    data["offset"] = offset;
    data["limit"] = limit;
    String body = json.encode(data);
    model = await ApiClient().getOrderList(body);
    return model;
  }
  @override
  Future<OrderDetailModel> getOrderDetails(String url) async {
    try {
      OrderDetailModel? model;
      model = await ApiClient().orderDetails(url);
      return model;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }  @override
  Future<BaseModel> reOrderData(String id,bool mergeCart) async {
    try {
      BaseModel? model;
      Map<String, dynamic> data ={};
      data["needCartMerge"] = mergeCart;
      String body = json.encode(data);
      model = await ApiClient().reorderOrder(id, body,);
      return model;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}