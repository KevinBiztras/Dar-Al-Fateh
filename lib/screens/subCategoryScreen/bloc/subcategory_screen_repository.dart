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
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';
import 'package:flutter_project_structure/utils/helper.dart';

import '../../../models/FilterDataModel.dart';

abstract class SubCategoryRepository {
  Future<GetFilterAttribute> getCategoryPage(int cid, int limit, int offset);

  Future<void> callCategoryApiAndUpdateHiveDB(
    HiveService hiveService,
    String categoryBoxName,
    String body,
  );
}

class SubCategoryRepositoryImp implements SubCategoryRepository {
  @override
  Future<GetFilterAttribute> getCategoryPage(
    int cid,
    int limit,
    int offset,
  ) async {
    GetFilterAttribute? model;
    Map<String, dynamic> data = {};
    data["cid"] = cid;
    data["limit"] = limit;
    data["offset"] = offset;

    String body = json.encode(data);
    debugPrint(body);
    final HiveService hiveService = HiveService();
    String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
    bool isCacheAvailable = await hiveService.isExists(
      boxName: categoryBoxName,
    );
    if (isCacheAvailable) {
      model = await hiveService.getCategoryPageBox(categoryBoxName);
      callCategoryApiAndUpdateHiveDB(hiveService, categoryBoxName, body);
      return model!;
    } else {
      try {
        model = await ApiClient().getCatalogData(body);
        hiveService.addBox(model, categoryBoxName);
        return model;
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
      }
    }
  }

  @override
  callCategoryApiAndUpdateHiveDB(
    HiveService hiveService,
    String categoryBoxName,
    String body,
  ) async {
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
