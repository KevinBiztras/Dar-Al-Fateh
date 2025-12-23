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
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/push_notifications_manager.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/utils/helper.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/encryption.dart';
import '../../../models/FilterDataModel.dart';
import '../../../models/HomeScreenModel.dart';

abstract class CategoryScreenRepository {
  Future<GetFilterAttribute> getCategoryPage(int cid, int limit, int offset);

  Future<HomePageData> getHomeData(
    String offset,
  );

  Future<void> callHomeApiAndUpdateHiveDB(
      HiveService hiveService, String homeBoxName, String offset);

  Future<void> callCategoryApiAndUpdateHiveDB(
      HiveService hiveService, String categoryBoxName, String body);
}

class CategoryScreenRepositoryImp implements CategoryScreenRepository {
  @override
  Future<GetFilterAttribute> getCategoryPage(
      int cid, int limit, int offset) async {
    GetFilterAttribute? model;
    Map<String, dynamic> data = {};
    data["cid"] = cid;
    data["limit"] = limit;
    data["offset"] = offset;
    String body = json.encode(data);
    debugPrint(body);
    final HiveService hiveService = HiveService();
    String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
    // bool isCacheAvailable =
    //     await hiveService.isExists(boxName: categoryBoxName);
    // if (isCacheAvailable) {
    //   // model = await hiveService.getCategoryPageBox(categoryBoxName);
    //   callCategoryApiAndUpdateHiveDB(hiveService, categoryBoxName, body);
    //   return model!;
    // } else {
      try {
        model = await ApiClient().getCatalogData(body);
        hiveService.addBox(model, categoryBoxName);
        return model;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    // }
  }

  @override
  Future<HomePageData> getHomeData(String offset) async {
    String firebaseToken = await PushNotificationsManager().createFcmToken()??"";
    String fcmDeviceId = AppSharedPref().getDeviceID() ?? "";
    HomePageData? model;
    try {
      Map<String, dynamic> data ={};
      var apiKey = generateEncodedApiKey(ApiConstant.baseData);
      data["fcmToken"] =  firebaseToken;
      data["fcmDeviceId"] = fcmDeviceId;
      String body = json.encode(data);
      model = await ApiClient().getHomePageData(apiKey,body, "text/plain",offset.toString(),"5");
      return model;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }

  }

  // @override
  // Future<HomePageData> getHomeData(String offset) async {
  //   final HiveService hiveService = HiveService();
  //   String homeBoxName = HiveConstants.getHomePageModelBoxName();
  //   bool isCacheAvailable = await hiveService.isExists(boxName: homeBoxName);
  //   String fcmToken = await PushNotificationsManager().createFcmToken() ?? "";
  //   String fcmDeviceId = AppSharedPref().getDeviceID() ?? "";
  //   HomePageData? model;
  //   if (isCacheAvailable) {
  //     model = await hiveService.getHomeDataBox(homeBoxName);
  //     callHomeApiAndUpdateHiveDB(hiveService, homeBoxName, offset);
  //     return model!;
  //   } else {
  //     try {
  //       Map<String, dynamic> data = {};
  //       var apiKey = generateEncodedApiKey(ApiConstant.baseData);
  //       data["fcmToken"] = fcmToken;
  //       data["fcmDeviceId"] = fcmDeviceId;
  //       String body = json.encode(data);
  //       model = await ApiClient().getHomePageData(apiKey, body, "text/plain", offset, "5");
  //       return model;
  //     } catch (e) {
  //       debugPrint(e.toString());
  //       throw Exception(e);
  //     }
  //   }
  // }

  @override
  callHomeApiAndUpdateHiveDB(
      HiveService hiveService, String homeBoxName, String offset) async {
    bool internetAvailable = await Helper().isNetworkAvailable();
    String fcmToken = await PushNotificationsManager().createFcmToken() ?? "";
    String fcmDeviceId = AppSharedPref().getDeviceID() ?? "";
    if (!internetAvailable) {
      return;
    }

    try {
      Map<String, dynamic> data = {};
      var apiKey = generateEncodedApiKey(ApiConstant.baseData);
      data["fcmToken"] = fcmToken;
      data["fcmDeviceId"] = fcmDeviceId;
      String body = json.encode(data);
      HomePageData? model;
      model = await ApiClient(isFromCache: true)
          .getHomePageData(apiKey, body, "text/plain", offset, "5");
      hiveService.addBox(model, homeBoxName);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  @override
  callCategoryApiAndUpdateHiveDB(
      HiveService hiveService, String categoryBoxName, String body) async {
    bool internetAvailable = await Helper().isNetworkAvailable();
    if (!internetAvailable) {
      return;
    }
    try {
      GetFilterAttribute? model;
      model = await ApiClient(isFromCache: true).getCatalogData(body);
      hiveService.addBox(model, categoryBoxName);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
