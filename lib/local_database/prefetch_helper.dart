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

import 'dart:convert';

import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/catalog/bloc/catalog_screen_repository.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_repository.dart';
import 'package:flutter_project_structure/screens/subCategoryScreen/bloc/subcategory_screen_repository.dart';

import '../models/FilterDataModel.dart';

class PrefetchHelper {
  static Future<void> prefetchFromHomePageResponse(
      HomepageDataList? dataModel) async {
    if (ApiConstant.isPreFetchingFeatureEnabled) {
      final HiveService hiveService = HiveService();

      dataModel?.data?.forEach((element) async {
        Map<String, dynamic> data = {};
        data["cid"] = element.categoryId ?? 0;
        data["limit"] = 10;
        data["offset"] = 0;
        String body = json.encode(data);
        String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
        bool cache = await hiveService.isExists(boxName: categoryBoxName);
        if (!cache) {
          SubCategoryRepositoryImp()
              .callCategoryApiAndUpdateHiveDB(
              hiveService, categoryBoxName, body);
        }
      });

      dataModel?.data?.forEach((element) async {
        if (element.bannerType == AppConstant.categoryTypeNotification) {
          Map<String, dynamic> data = {};
          data["cid"] = element.id;
          data["limit"] = 10;
          data["offset"] = 0;
          String body = json.encode(data);
          String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);

          bool cache = await hiveService.isExists(boxName: categoryBoxName);

          if (!cache) {
            CategoryScreenRepositoryImp().callCategoryApiAndUpdateHiveDB(
                hiveService, categoryBoxName, body);
          }
        } else if (element.bannerType == AppConstant.customTypeNotification) {
          Map<String, dynamic> data = {};
          data["limit"] = 10;
          data["domain"] = element.domain ?? "";
          String body = json.encode(data);
          String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);

          bool cache = await hiveService.isExists(boxName: categoryBoxName);

          if (!cache) {
            CategoryScreenRepositoryImp().callCategoryApiAndUpdateHiveDB(
                hiveService, categoryBoxName, body);
          }
        } else if (element.bannerType == AppConstant.productTypeNotification) {
          String productId = element.id.toString();
          String productDataBoxName =
          HiveConstants.getProductDataBoxName(productId);

          bool cache = await hiveService.isExists(boxName: productDataBoxName);

          if (!cache) {
            ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(
                hiveService, productDataBoxName, productId);
          }
        }
      });

      dataModel?.data?.forEach((element) async {
        element.products?.forEach((product) async {
          String productId = product.templateId.toString();
          String productDataBoxName =
          HiveConstants.getProductDataBoxName(productId);

          bool cache = await hiveService.isExists(boxName: productDataBoxName);
          if (!cache) {
            ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(
                hiveService, productDataBoxName, productId);
          }
        });
      });
      if (dataModel?.type == "slider") {
        dataModel?.data?.forEach((element) async {
          Map<String, dynamic> data = {};
          data["limit"] = 10;
          data["offset"] = 0;
          String body = json.encode(data);
          String url = element.url ?? "";
          String productSliderBoxName =
          HiveConstants.getProductSliderBoxName(body, url);
          bool cache = await hiveService.isExists(
              boxName: productSliderBoxName);
          if (!cache) {
            CategoryScreenRepositoryImp().callProductSliderApiAndUpdateHiveDB(
                hiveService, productSliderBoxName, body, url);
          }
        });
      }
    }
  }

  static Future<void> prefetchFromCategoryPageResponse(
      GetFilterAttribute ? dataModel, int cid, String url, String domain) async {
    if (ApiConstant.isPreFetchingFeatureEnabled) {
      final HiveService hiveService = HiveService();

      int offset = 10;
      int tcount = dataModel?.tcount ?? 0;
      while (offset < tcount) {
        if (url.isEmpty) {
          Map<String, dynamic> data = {};
          if (cid > 0) data["cid"] = cid;
          data["limit"] = 10;
          data["offset"] = offset;
          if (domain.isNotEmpty) data["domain"] = domain;
          String body = json.encode(data);
          String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
          bool cache = await hiveService.isExists(boxName: categoryBoxName);
          if (!cache) {
            SubCategoryRepositoryImp()
                .callCategoryApiAndUpdateHiveDB(
                hiveService, categoryBoxName, body);
          }
        } else {
          Map<String, dynamic> data = {};
          data["limit"] = 10;
          data["offset"] = offset;
          String body = json.encode(data);
          String productSliderBoxName =
          HiveConstants.getProductSliderBoxName(body, url);

          bool cache = await hiveService.isExists(
              boxName: productSliderBoxName);

          if (!cache) {
            CategoryScreenRepositoryImp().callProductSliderApiAndUpdateHiveDB(
                hiveService, productSliderBoxName, body, url);
          }
        }

        offset = offset + 10;
      }

      dataModel?.products?.forEach((element) async {
        String productId = element.templateId.toString();
        String productDataBoxName =
        HiveConstants.getProductDataBoxName(productId);

        bool cache = await hiveService.isExists(boxName: productDataBoxName);

        if (!cache) {
          ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(
              hiveService, productDataBoxName, productId);
        }
      });
    }
  }
}
