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
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/database.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/entities/recent_product.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/recent_view_controller.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../models/HomeScreenModel.dart';
import '../item_card.dart';
import '../product_item_full_width.dart';

Widget buildGridProduct(
  List<Products> products,
  AppLocalizations? _localizations, {
  String? url,
  bool isCatalog = false,
  required VoidCallback postWishlistClick,
  void Function(Products product, int quantity)? onAddToCart,
}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.74,
    ),
    itemCount: (products.length.isEven) ? products.length : products.length + 1,

    itemBuilder: (BuildContext context, int index) {
      if (index == products.length) {
        return isCatalog
            ? Container()
            : GestureDetector(
                onTap: () {
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
                    catalogPage,
                    arguments: getCatalogMap(
                      url ?? "",
                      true,
                      "Catalog",
                      customerId: 0,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSizes.linePadding),
                    ),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  margin: const EdgeInsets.only(
                    top: AppSizes.normalPadding,
                    left: AppSizes.normalPadding,
                    right: AppSizes.normalPadding,
                  ),

                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_circle_outline),
                        const SizedBox(height: AppSizes.imageRadius),
                        Text(
                          _localizations?.translate(
                                AppStringConstant.viewAll,
                              ) ??
                              "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
        } else {
        var data = products[index];
        // ----------Will Call if type is AppConstant.productDefault
        // ----------ItemCard Widget is used to show each product in grid
        // ----------imageSize is calculated to fit two items in one row with padding
        return ItemCard(
          product: data,
          postWishlistClick: postWishlistClick,
          imageSize: (AppSizes.width / 2.3) - AppSizes.mediumPadding,
          onAddToCart: onAddToCart,
        );
      }
    },
  );
}

Widget buildHorizontalProduct(
  List<Products> products,
  AppLocalizations? _localizations, {
  String? url,
  required VoidCallback postWishlistClick,
}) {
  //----------Will Call if type is AppConstant.productDefault
  return SizedBox(
    width: AppSizes.width.toDouble(),
    height: AppSizes.width / 1.5,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: (products.length.isOdd && (url != null))
          ? products.length + 1
          : products.length,
      itemBuilder: (BuildContext context, int index) {
        if ((index == products.length) && url != null) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                catalogPage,
                arguments: getCatalogMap(url, true, "Catalog", customerId: 0),
              );
            },
            child: Container(
              height: ((AppSizes.width / 2.5) - 8) - 3,
              width:
                  (AppSizes.width -
                      (AppSizes.linePadding + AppSizes.linePadding)) /
                  2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.linePadding),
                ),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              margin: const EdgeInsets.only(
                top: AppSizes.normalPadding,
                left: AppSizes.normalPadding,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_circle_outline),
                    const SizedBox(height: AppSizes.imageRadius),
                    Text(
                      _localizations?.translate(AppStringConstant.viewAll) ??
                          "",
                      // 'name of you',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          var data = products[index];
          return ItemCard(
            product: data,
            imageSize:
                (AppSizes.width -
                    (AppSizes.linePadding + AppSizes.linePadding)) /
                2.5,
            postWishlistClick: postWishlistClick,
          );
        }
      },
    ),
  );
}

Widget buildVertical(
  List<Products> products,
  AppLocalizations? _localizations, {
  String? url,
  required VoidCallback postWishlistClick,
}) {
  //----------Will Call if type is AppConstant.productDefault
  return SizedBox(
    width: AppSizes.width * 2,
    height: (AppSizes.width * 1.9),
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: (products.length.isOdd && (url != null))
          ? products.length + 1
          : products.length,
      itemBuilder: (BuildContext context, int index) {
        if ((index == products.length) && url != null) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                catalogPage,
                arguments: getCatalogMap(url, true, "Catalog", customerId: 0),
              );
            },
            child: Container(
              height: ((AppSizes.width / 2.5) - 8) - 3,
              width:
                  (AppSizes.width -
                      (AppSizes.linePadding + AppSizes.linePadding)) /
                  2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.linePadding),
                ),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              margin: const EdgeInsets.only(
                top: AppSizes.normalPadding,
                left: AppSizes.normalPadding,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_circle_outline),
                    const SizedBox(height: AppSizes.imageRadius),
                    Text(
                      _localizations?.translate(AppStringConstant.viewAll) ??
                          "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          var data = products[index];
          return ItemCard(
            product: data,
            imageSize: (AppSizes.width * 0.9),
            postWishlistClick: postWishlistClick,
          );
        }
      },
    ),
  );
}

Widget buildStaggered(
  List<Products> products, {
  required VoidCallback postWishlistClick,
}) {
  //----------Will Call for random widgets
  List<Widget> customViews = [];
  for (int i = 0; i < products.length; i++) {
    if ((i + 1) % 3 == 0) {
      customViews.add(
        SizedBox(
          height: (AppSizes.width / 1.8),
          width: AppSizes.width - (AppSizes.linePadding + AppSizes.linePadding),
          child: ProductItemFullWidth(product: products[i]),
        ),
      );
      i++;
    } else {
      if (i == 0) {
        continue;
      }
      customViews.add(
        Row(
          children: [
            SizedBox(
              height: AppSizes.width / 1.34,
              width:
                  AppSizes.width / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
              child: ItemCard(
                product: products[i - 1],
                imageSize:
                    AppSizes.width / 2 -
                    (AppSizes.linePadding + AppSizes.linePadding),
                postWishlistClick: postWishlistClick,
              ),
            ),
            SizedBox(
              height: AppSizes.width / 1.34,
              width:
                  AppSizes.width / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
              child: ItemCard(
                product: products[i],
                imageSize:
                    AppSizes.width / 2 -
                    (AppSizes.linePadding + AppSizes.linePadding),
                postWishlistClick: postWishlistClick,
              ),
            ),
          ],
        ),
      );
    }
  }
  return Column(children: customViews);
}

Widget buildStaggeredGrid(
  List<Products> products,
  AppLocalizations? _localizations, {
  required VoidCallback postWishlistClick,
}) {
  if (products.length < 5) {
    var list = [
      buildHorizontalProduct(
        products,
        _localizations,
        postWishlistClick: postWishlistClick,
      ),
      buildGridProduct(
        products,
        _localizations,
        postWishlistClick: postWishlistClick,
      ),
      buildStaggered(products, postWishlistClick: postWishlistClick),
    ];
    return (list..shuffle()).first;
  } else {
    var totalWidth =
        AppSizes.width - ((AppSizes.imageRadius + AppSizes.imageRadius));
    var imageHeight = AppSizes.height / 1.9;
    return Row(
      children: [
        SizedBox(
          width: totalWidth * 0.55,
          child: Column(
            children: [
              SizedBox(
                height: totalWidth * 0.93,
                child: ItemCard(
                  product: products[0],
                  imageSize: totalWidth * 0.63,
                  postWishlistClick: postWishlistClick,
                ),
              ),
              SizedBox(
                height: totalWidth * 0.93,
                child: ItemCard(
                  product: products[1],
                  imageSize: totalWidth * 0.63,
                  postWishlistClick: postWishlistClick,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: totalWidth * 0.45,
          child: Column(
            children: [
              SizedBox(
                height: totalWidth * 0.62,
                child: ItemCard(
                  product: products[2],
                  imageSize: totalWidth / 3,
                  postWishlistClick: postWishlistClick,
                ),
              ),
              SizedBox(
                height: totalWidth * 0.62,
                child: ItemCard(
                  product: products[3],
                  imageSize: totalWidth / 3,
                  postWishlistClick: postWishlistClick,
                ),
              ),
              SizedBox(
                height: totalWidth * 0.62,
                child: ItemCard(
                  product: products[4],
                  imageSize: totalWidth / 3,
                  postWishlistClick: postWishlistClick,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
