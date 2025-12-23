/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */



import 'dart:convert';
import '../../../helper/app_shared_pref.dart';
import '../../../models/BaseModel.dart';
import '../../../models/compare_product_model.dart';
import '../../../networkManager/api_client.dart';

abstract class CompareProductRepository{
   Future<CompareProductModel> getCompareProductDetails();
  Future<BaseModel?> addToWishList(String productId,String productName);
  Future<BaseModel?> removeFromWishList(String productId);
  Future<BaseModel?> addToCart(String productId, String qty );


}

class CompareProductRepositoryImp extends CompareProductRepository{
  @override
  Future<CompareProductModel> getCompareProductDetails() async{
    CompareProductModel? data;
    try {
      List ? compareList = AppSharedPref().getCompareData();
      print("compareList-->$compareList");
      data = await ApiClient().customerCompareList((compareList ?? []).toString());
    } catch (e) {
      throw Exception(e);
    }
    return data;
  }

  /// ****AddToWishList**/
  @override
  Future<BaseModel?> addToWishList(String productId,String productName) async {
    BaseModel? model;
    Map<String, dynamic> data ={};
    data["productId"] = productId;
    data["productName"] = productName;
    String body = json.encode(data);
    model = await ApiClient().addToWishlist("text/plain", body);
    return model;
  }

  /// ****RemoveFromWishList**/
  @override
  Future<BaseModel?> removeFromWishList(String productId) async {

    var responseData = await ApiClient().removeItemFromWishlist(productId);
    return responseData;
  }

  /// ****Add to Cart**/
  ///
  @override
  Future<BaseModel?> addToCart(String productId, String qty) async {

      BaseModel? model;
      Map<String, dynamic> data = {};
      data["productId"] = productId;
      data["add_qty"] = qty;
      String body = json.encode(data);
      model = await ApiClient().addToCart(body, "text/plain");
      return model;
    }

}