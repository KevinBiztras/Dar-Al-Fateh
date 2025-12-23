import 'dart:convert';

import 'package:flutter/material.dart';
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

import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/helper/push_notifications_manager.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/local_database/prefetch_helper.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/utils/helper.dart';

abstract class HomeScreenRepository {
  Future<HomePageData> getHomeData(int offset);

  Future<void> callApiAndUpdateHiveDB(HiveService hiveService,
      String homeBoxName, bool prefetch, String offset);
}

class HomeScreenRepositoryImp implements HomeScreenRepository {
  @override
  Future<HomePageData> getHomeData(int offset) async {
    final HiveService hiveService = HiveService();
    String homeBoxName = HiveConstants.getHomePageModelBoxName();
    String firebaseToken =
        await PushNotificationsManager().createFcmToken() ?? "";
    String fcmDeviceId = AppSharedPref().getDeviceID() ?? "";
    HomePageData? model;
    try {
      Map<String, dynamic> data = {};
      var apiKey = generateEncodedApiKey(ApiConstant.baseData);
      data["fcmToken"] = firebaseToken;
      data["fcmDeviceId"] = fcmDeviceId;
      String body = json.encode(data);
      model = await ApiClient()
          .getHomePageData(apiKey, body, "text/plain", offset.toString(), "5");
      if (offset == 0) {
        hiveService.addBox(model, homeBoxName);
      }
      model.homepageDataList?.forEach(
          (element) => PrefetchHelper.prefetchFromHomePageResponse(element));

      return model;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  @override
  callApiAndUpdateHiveDB(HiveService hiveService, String homeBoxName,
      bool prefetch, String offset) async {
    bool internetAvailable = await Helper().isNetworkAvailable();
    String firebaseToken =
        await PushNotificationsManager().createFcmToken() ?? "";
    String fcmDeviceId = AppSharedPref().getDeviceID() ?? "";
    if (!internetAvailable) {
      return;
    }
    try {
      Map<String, dynamic> data = {};
      var apiKey = generateEncodedApiKey(ApiConstant.baseData);
      data["fcmToken"] = firebaseToken;
      data["fcmDeviceId"] = fcmDeviceId;
      String body = json.encode(data);
      HomePageData? model;
      model = await ApiClient(isFromCache: true)
          .getHomePageData(apiKey, body, "text/plain", offset, "5");
      hiveService.addBox(model, homeBoxName);
      if (prefetch) {
        model.homepageDataList?.forEach(
            (element) => PrefetchHelper.prefetchFromHomePageResponse(element));
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
