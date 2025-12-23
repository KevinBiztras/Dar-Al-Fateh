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

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/models/ResponseModel.dart';
import 'package:flutter_project_structure/models/ReviewListModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/utils/helper.dart';

abstract class ProductScreenRepository {
  Future<ProductScreenModel> getProductData(String productId);

  Future<ReviewListModel> getProductReviews(String productId);

  Future<BaseModel> likeDislikeReview(String reviewId, bool isHelpful);

  Future<BaseModel> addToWishlist(String productId,String productName);

  Future<BaseModel> removeFromWishlist(String productId);
}

class ProductScreenRepositoryImp implements ProductScreenRepository {
  @override
  Future<ProductScreenModel> getProductData(String productId) async {
    ProductScreenModel? model;
    final HiveService hiveService = HiveService();
    String productDataBoxName = HiveConstants.getProductDataBoxName(productId);
    model = await ApiClient().getProductData(generateEncodedApiKey(ApiConstant.baseData), productId);
    hiveService.addBox(model, productDataBoxName);
    return model;
    // bool isCacheAvailable = await hiveService.isExists(boxName: productDataBoxName);
    // if (isCacheAvailable) {
    //   model = await hiveService.getProductPageBox(productDataBoxName);
    //   callProductDataApiAndUpdateHiveDB(hiveService, productDataBoxName, productId);
    //   return model!;
    // } else {
    //   try {
    //     model = await ApiClient().getProductData(generateEncodedApiKey(ApiConstant.baseData), productId);
    //     hiveService.addBox(model, productDataBoxName);
    //     return model;
    //   } catch (e) {
    //     throw Exception(e);
    //   }
    // }
  }

  callProductDataApiAndUpdateHiveDB(HiveService hiveService, String productDataBoxName, String productId) async{
    bool internetAvailable = await Helper().isNetworkAvailable();
    if(!internetAvailable) {
      return;
    }
    try {
      ProductScreenModel? model;
      model = await ApiClient(isFromCache: true).getProductData(generateEncodedApiKey(ApiConstant.baseData), productId);
      hiveService.addBox(model, productDataBoxName);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      throw Exception(e);
    }
  }

  @override
  Future<BaseModel> addToWishlist(String productId, String productName) async{
    BaseModel? model;
    Map<String, dynamic> data ={};
    data["productId"] = productId;
    data["productName"] = productName;
    String body = json.encode(data);
    model = await ApiClient().addToWishlist("text/plain", body);
    return model;
  }

  @override
  Future<BaseModel> removeFromWishlist(String productId) async{
    BaseModel? model;
    model = await ApiClient().removeItemFromWishlist(productId,);
    return model;
  }




  @override
  Future<ReviewListModel> getProductReviews(String productId) async {
    Map<String, dynamic> data = {};
    data["template_id"] = int.parse(productId);

    String body = json.encode(data);

    ReviewListModel? model;
    model = await ApiClient().getReviewList(body);
    return model;
  }

  @override
  Future<BaseModel> likeDislikeReview(String reviewId, bool isHelpful) async {
    Map<String, dynamic> data = {};
    data["review_id"] = int.parse(reviewId);
    data["ishelpful"] = isHelpful;

    String body = json.encode(data);

    BaseModel model = await ApiClient().likeDislikeReview(body);
    return model;
  }

  @override
  Future<BaseModel> addTocart(String productId, int qty) async{
    BaseModel? model;
    Map<String, dynamic> data = {};
    data["productId"] = productId;
    data["add_qty"] = qty;
    String body = json.encode(data);
    model = await ApiClient().addToCart(body, "text/plain");
    return model;
  }

  @override
  Future<BaseModel> buyNow(String productId, int qty)async{
    BaseModel? model;
    Map<String, dynamic> data = {};
    data["productId"] = productId;
    data["add_qty"] = qty;
    String body = json.encode(data);
    model = await ApiClient().addToCart(body, "text/plain");
    return model;
  }

  @override
  Future<BaseModel> addReview(int rating, String title, String review, int templateId) async{
    BaseModel? model;
    Map<String, dynamic> data = {};
    data["rate"] = rating;
    data["title"] = rating;
    data["detail"] = rating;
    data["template_id"] = rating;
    String body = json.encode(data);
    model = await ApiClient().addReview("text/plain", body);
    return model;
  }



}
