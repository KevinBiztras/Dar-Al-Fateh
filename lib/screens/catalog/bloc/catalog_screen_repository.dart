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

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/local_database/prefetch_helper.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/utils/helper.dart';

import '../../../models/FilterDataModel.dart';

// import '../../../marketplace/marketplaceModel/CatalogArgumentModel.dart';

abstract class CatalogScreenRepository{
  Future<GetFilterAttribute> getCategoryPage(int cid, int limit, int offset,String order);
  Future<GetFilterAttribute> getCatalogDatafromHome(String url, int limit, int offset);
  Future<GetFilterAttribute> getCatalogDataFromNotification(int limit, String domain);
  // Future<CategoryScreenModel> getSellerCatalog( CatalogArgumentModel data);
  Future<GetFilterAttribute> getFilterProducts(Map<String,dynamic >  data);


}

class CategoryScreenRepositoryImp implements CatalogScreenRepository{
  @override
  Future<GetFilterAttribute> getCategoryPage(int cid, int limit, int offset,String order) async {
    GetFilterAttribute? model;
    Map<String, dynamic> data ={};
    data["cid"] = cid;
    data["limit"] = limit;
    data["offset"] = offset;
    data["order"] = order;
    String body = json.encode(data);
    debugPrint(body);
    final HiveService hiveService = HiveService();
    String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
    bool isCacheAvailable = await hiveService.isExists(boxName: categoryBoxName);
    if (!ApiConstant.baseUrl.contains('example.com') && isCacheAvailable) {
      model = await hiveService.getCategoryPageBox(categoryBoxName);
      callCategoryApiAndUpdateHiveDB(hiveService, categoryBoxName, body);
      return model!;
    }else {
      try {
        model = await ApiClient().getCatalogData(body);
        hiveService.addBox(model, categoryBoxName);
        PrefetchHelper.prefetchFromCategoryPageResponse(model, cid, "","");
        return model;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    }
  }

  @override
  Future<GetFilterAttribute> getCatalogDatafromHome(String url, int limit, int offset) async{
    GetFilterAttribute? model;
    Map<String, dynamic> data ={};
    data["limit"] = limit;
    data["offset"] = offset;
    String body = json.encode(data);
    debugPrint(body);
    final HiveService hiveService = HiveService();
    String productSliderBoxName = HiveConstants.getProductSliderBoxName(body, url);
    debugPrint("productSliderBoxName $productSliderBoxName");
    bool isCacheAvailable = await hiveService.isExists(boxName: productSliderBoxName);
    if (!ApiConstant.baseUrl.contains('example.com') && isCacheAvailable) {
      model = await hiveService.getProductSliderBox(productSliderBoxName);
      callProductSliderApiAndUpdateHiveDB(hiveService, productSliderBoxName, body, url);
      return model!;
    }else {
      try {
        model = await ApiClient().getProductSliderData(url, body, "text/plain");
        hiveService.addBox(model, productSliderBoxName);
        PrefetchHelper.prefetchFromCategoryPageResponse(model,0, url,"");
        return model;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    }
  }

  @override
  Future<GetFilterAttribute> getCatalogDataFromNotification( int limit, String domain) async{
    GetFilterAttribute? model;
    Map<String, dynamic> data ={};
    data["limit"] = limit;
    data["domain"] = domain;
    String body = json.encode(data);
    debugPrint(body);
    final HiveService hiveService = HiveService();
    String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
    bool isCacheAvailable = await hiveService.isExists(boxName: categoryBoxName);
    if (!ApiConstant.baseUrl.contains('example.com') && isCacheAvailable) {
      model = await hiveService.getCategoryPageBox(categoryBoxName);
      callCategoryApiAndUpdateHiveDB(hiveService, categoryBoxName, body);
      return model!;
    }else {
      try {
        model = await ApiClient().getCatalogData(body);
        hiveService.addBox(model, categoryBoxName);
        PrefetchHelper.prefetchFromCategoryPageResponse(model,0, "",domain);
        return model;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    }
  }

  callCategoryApiAndUpdateHiveDB(HiveService hiveService, String categoryBoxName, String body) async{
    bool internetAvailable = await Helper().isNetworkAvailable();
    if(!internetAvailable) {
      return;
    }
    try{
      Map<String, dynamic> data = json.decode(body);
      int cid = data["cid"]??0 ;
      String domain = data["domain"]??"";
      GetFilterAttribute? model;
      model = await ApiClient(isFromCache: true).getCatalogData(body);
      hiveService.addBox(model, categoryBoxName);
      PrefetchHelper.prefetchFromCategoryPageResponse(model, cid, "",domain);
    }catch (e){
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  callProductSliderApiAndUpdateHiveDB(HiveService hiveService, String productSliderBoxName, String body, String url) async{

    bool internetAvailable = await Helper().isNetworkAvailable();
    if(!internetAvailable) {
      return;
    }
    try{
      GetFilterAttribute? model;
      model = await ApiClient(isFromCache: true).getProductSliderData(url, body, "text/plain");
      hiveService.addBox(model, productSliderBoxName);
      PrefetchHelper.prefetchFromCategoryPageResponse(model, 0, url,"");
    }catch (e){
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
  // @override
  // Future<CategoryScreenModel> getSellerCatalog(CatalogArgumentModel data) async{
  //   CategoryScreenModel? model;
  //
  //   String body = json.encode(data.getData());
  //   print(body);
  //   model = await ApiClient().getCatalogData(body);
  //   return model;
  // }
  @override
  Future<GetFilterAttribute> getFilterProducts(Map<String,dynamic >  data) async {

    GetFilterAttribute? model;
    String body = json.encode(data);
    try {
      model = await ApiClient().getFilterProducts(body);
    } catch (error, stacktrace) {
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return model!;
  }

}
