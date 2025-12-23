/*
 *  Webkul Software.
 *
 *  @package  Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html 
 *  @link https://store.webkul.com/license.html
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:hive/hive.dart';
import '../models/FilterDataModel.dart';

class HiveService {
  Future<bool> isExists({required String boxName}) async {
    if (!ApiConstant.isCacheFeatureEnabled) {
      return false;
    }
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  Future<void> addBox<T>(T item, String boxName) async {

    if(item == null || boxName.isEmpty) {
      return;
    }

    final openBox = await Hive.openBox(boxName);

    try {
      if(openBox.length > 0 ) {
        openBox.deleteAt(0);
      }
    } catch (e, stacktrace) {
      debugPrint("HiveService.addBox boxName: $boxName");
      debugPrint("HiveService.addBox exception: $e");
      debugPrintStack(stackTrace: stacktrace, label: e.toString());
    } finally {
      await Hive.openBox(boxName).then((value) => value.add(item));
      // openBox.add(item);
      Hive.close();
    }
  }
  // Future<void> addBox<T>(T item, String boxName) async {
  //   Box? box;
  //   if (item == null || boxName.isEmpty) return;
  //
  //   if (!Hive.isBoxOpen(boxName)) {
  //     box = await Hive.openBox(boxName);
  //   } else {
  //     box = Hive.box(boxName);
  //   }
  //   try {
  //     List? existingData = box.values.toList();
  //       existingData.add(item);
  //       await box.clear();
  //       await box.addAll(existingData ?? []);
  //   } catch (e, stacktrace) {
  //     debugPrint("HiveService.addBox boxName: $boxName");
  //     debugPrint("HiveService.addBox exception: $e");
  //     debugPrintStack(stackTrace: stacktrace, label: e.toString());
  //   }
  // }

  Future<SplashScreenModel?> getSplashDataBox(String boxName) async {
    SplashScreenModel? splashPageBox;
    final openBox = await Hive.openBox(boxName);
    splashPageBox = openBox.getAt(0);
    return splashPageBox;
  }

  Future<HomePageData?> getHomeDataBox(String boxName) async {
    HomePageData? homePageBox;
    final openBox = await Hive.openBox(boxName);
    if (openBox.isNotEmpty) {
      homePageBox = openBox.getAt(0);
    }
    return homePageBox;
  }

  Future<GetFilterAttribute?> getCategoryPageBox(String boxName) async {
    GetFilterAttribute? categoryPageBox;
    final openBox = await Hive.openBox(boxName);
    categoryPageBox = openBox.getAt(0);
    return categoryPageBox;
  }

  Future<GetFilterAttribute?> getProductSliderBox(String boxName) async {
    GetFilterAttribute? categoryPageBox;
    final openBox = await Hive.openBox(boxName);
    categoryPageBox = openBox.getAt(0);
    return categoryPageBox;
  }

  Future<ProductScreenModel?> getProductPageBox(String boxName) async {
    ProductScreenModel? productPageBox;
    final openBox = await Hive.openBox(boxName);
    productPageBox = openBox.getAt(0);
    return productPageBox;
  }
}
