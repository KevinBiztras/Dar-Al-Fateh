/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';
import '../../../helper/app_shared_pref.dart';
import '../../../models/HomeScreenModel.dart';

Widget suggestionList(
  List<Products> products,
  BuildContext context,
  AppLocalizations? _localizations,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.extraPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(AppSizes.extraPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _localizations?.translate(AppStringConstant.relatedProduct) ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.extraPadding),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AppSharedPref().addSearchItem(products[index].name ?? "");
                    AppDatabase.getDatabase().then(
                      (value) => value.recentProductDao
                          .insertRecentProduct(
                            RecentProduct(
                              templateId: products[index].templateId.toString(),
                              name: products[index].name,
                              priceUnit: products[index].priceUnit,
                              priceReduce: products[index].priceReduce,
                              image: products[index].thumbNail,
                              productId: products[index].productId,
                              productCount: products[index].productCount,
                            ),
                          )
                          .then(
                            (value) => RecentViewController.controller.sink.add(
                              products[index].productId.toString(),
                            ),
                          ),
                    );

                    Navigator.pushNamed(
                      context,
                      productPage,
                      arguments: getProductDataMap(
                        products[index].name ?? "",
                        (products[index].templateId ?? "").toString(),
                      ),
                    ).then((val) {
                      print("val---->$val");
                      Navigator.pushReplacementNamed(context, searchPage);
                    });
                  },
                  child: Row(
                    children: [
                      ImageView(
                        url: products[index].thumbNail,
                        height: AppSizes.width / 7,
                        width: AppSizes.width / 7,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(AppSizes.imageRadius),
                          padding: const EdgeInsets.all(AppSizes.imageRadius),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].name ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppSizes.imageRadius / 2),
                              Text(products[index].priceUnit ?? ''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: AppSizes.genericPadding),
              itemCount: products.length ?? 0,
            ),
          ],
        ),
      ),
    ),
  );
}
