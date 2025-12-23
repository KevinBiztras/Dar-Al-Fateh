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
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/utils/helper.dart';

import '../../../models/walkThroughModel.dart';

abstract class SplashScreenRepository {
  Future<SplashScreenModel> getSplashData();
  Future<WalkThroughModel> getWalkThroughData();
}

class SplashscreenRepositoryImp implements SplashScreenRepository {
  @override
  Future<SplashScreenModel> getSplashData() async {
    final HiveService hiveService = HiveService();
    String splashBoxName = HiveConstants.getSplashModelBoxName();
    bool isCacheAvailable = await hiveService.isExists(boxName: splashBoxName);

    if (isCacheAvailable) {
      SplashScreenModel? splashScreenModel;
      splashScreenModel = await hiveService.getSplashDataBox(splashBoxName);
      callApiAndUpdateHiveDB(hiveService, splashBoxName);
      debugPrint("FROM CACHE");
      return splashScreenModel!;
    } else {
      try {
        SplashScreenModel? splashScreenModel;
        splashScreenModel = await ApiClient().getSplashData(
          generateEncodedApiKey(ApiConstant.baseData),
        );
        hiveService.addBox(splashScreenModel, splashBoxName);
        AppSharedPref().setSplashData(splashScreenModel);
        if (AppSharedPref().getAppCurrency() == null ||
            splashScreenModel.allPricelists == null ||
            splashScreenModel.allPricelists!.length == 0) {
          debugPrint("getSplashData  setAppCurrency");
          // AppSharedPref().setAppCurrency(splashScreenModel.defaultPricelist![0]);
          AppSharedPref().setAppCurrency(
            splashScreenModel.defaultPricelist?.isNotEmpty == true
                ? splashScreenModel.defaultPricelist![0]
                : "\$",
          );
        }
        return splashScreenModel;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    }
  }

  callApiAndUpdateHiveDB(HiveService hiveService, String boxName) async {
    bool internetAvailable = await Helper().isNetworkAvailable();
    if (!internetAvailable) {
      return;
    }
    try {
      SplashScreenModel? splashScreenModel;
      splashScreenModel = await ApiClient(
        isFromCache: true,
      ).getSplashData(generateEncodedApiKey(ApiConstant.baseData));
      hiveService.addBox(splashScreenModel, boxName);
      AppSharedPref().setSplashData(splashScreenModel);
      if (AppSharedPref().getAppCurrency() == null ||
          splashScreenModel.allPricelists == null ||
          splashScreenModel.allPricelists!.length == 0) {
        debugPrint("callApiAndUpdateHiveDB  setAppCurrency");
        // AppSharedPref().setAppCurrency(splashScreenModel.defaultPricelist![0]);
        AppSharedPref().setAppCurrency(
          splashScreenModel.defaultPricelist?.isNotEmpty == true
              ? splashScreenModel.defaultPricelist![0]
              : "\$",
        );
      }
      debugPrint("CACHE UPDATED");
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<WalkThroughModel> getWalkThroughData() async {
    WalkThroughModel? data;
    try {
      data = await ApiClient().getWalkThrough();
      print(data);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return data;
  }
}
