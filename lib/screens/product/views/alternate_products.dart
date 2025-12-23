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

import 'package:flutter/cupertino.dart';
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
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/screens/home/views/item_card.dart';

import '../../../config/theme.dart';
import '../../../constants/app_constants.dart';
import '../../../models/ProductScreenModel.dart';

class AlternateProductsList extends StatelessWidget {
  List<AlternativeProducts>? alternativeProducts;

  AlternateProductsList(this.alternativeProducts);

  @override
  Widget build(BuildContext context) {
    if ((alternativeProducts ?? []).isNotEmpty) {
      return Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.only(left: AppSizes.imageRadius, right: AppSizes.imageRadius, bottom: AppSizes.imageRadius),
        margin: const EdgeInsets.only(top: AppSizes.normalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: AppSizes.sidePadding),
              child: Text(
                  AppLocalizations.of(context)
                      ?.translate(AppStringConstant.alternateProducts) ??
                      "",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            SizedBox(
              height: AppSizes.width / 2,
              width: AppSizes.width,
              child: ListView.builder(
                  itemCount: alternativeProducts?.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = alternativeProducts![index];
                    return productCard(data, context);
                  }),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget productCard(AlternativeProducts product, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(productPage,
            arguments:
            getProductDataMap(product.name ?? '', product.templateId.toString()));
      },
      child: SizedBox(
        height: AppSizes.width / 1.8,
        width: AppSizes.width / 2.5,
        child: Card(
          color: Theme.of(context).canvasColor,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.normalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageView(
                  url: product.image,
                  width: (AppSizes.width / 2) * 0.7,
                  height: (AppSizes.width / 2) * 0.66,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  "${product.name}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                // Visibility(
                //     visible: (product.priceReduce ?? '').isNotEmpty,
                //     child: Text(product.priceUnit ?? '',
                //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(decoration: TextDecoration.lineThrough),
                //     )),
                // Visibility(
                //   visible: (product.priceReduce ?? '').isNotEmpty,
                //   child: const SizedBox(
                //     height: 2.0,
                //   ),
                // ),
                Text(
                  (product.priceReduce ?? '').isNotEmpty
                      ? product.priceReduce ?? ''
                      : product.priceUnit ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                // const SizedBox(
                //   height: 2.0,
                // ),
                // Text(
                //   "${product.name}",
                //   textAlign: TextAlign.center,
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 1,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
