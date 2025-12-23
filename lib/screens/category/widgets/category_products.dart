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
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/route_constant.dart';
import '../../../helper/loader.dart';
import '../../../models/HomeScreenModel.dart';
import '../../home/views/home_collection_view.dart';
import '../../home/views/item_card.dart';

Widget buildCategoryProducts(
    List<Products> products,
    AppLocalizations? _localizations,
    BuildContext context,
    bool? isLoading,
    int? cid,
    String categoryName,
    VoidCallback postWishlistClick) {
  double itemWidth = (AppSizes.width - (AppSizes.linePadding * 2)) / 5.5;
  double itemHeight = (itemWidth + 6)/ 0.7; // Inverse of aspect ratio

  return (isLoading ?? false)
      ? Loader()
      : (products.isNotEmpty)
      ? Visibility(
    visible: products.isNotEmpty,
    child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSizes.imageRadius,AppSizes.imageRadius,AppSizes.imageRadius,AppSizes.imageRadius),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                  const EdgeInsets.all(AppSizes.imageRadius / 2),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(AppSizes.imageRadius / 2),
                    // color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Text(
                    _localizations
                        ?.translate(AppStringConstant.products) ??
                        "",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                viewAllButton(context, () {
                  Navigator.of(context).pushNamed(catalogPage,
                      arguments: getCatalogMap("", false, categoryName,
                          customerId: cid!));
                }),
              ],
            ),
            const SizedBox(
              height: AppSizes.imageRadius,
            ),
            SingleChildScrollView(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable GridView scroll
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight, // Dynamic aspect ratio
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = products[index];
                    return  GestureDetector(
                      onTap: () {},
                      child: ItemCard(
                        product: data,
                        imageSize: (AppSizes.width -
                            (AppSizes.linePadding +
                                AppSizes.linePadding)) /
                            3,
                        postWishlistClick: postWishlistClick,
                      ),
                    );
                  }),
            ),
          ],
        )),

  )
      : Center(
    child: Text(
        _localizations?.translate(AppStringConstant.noProductFound) ??
            ''),
  );
}
