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
import 'package:flutter_project_structure/helper/app_localizations.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({
    this.grandTotal,
    this.totalProducts,
    this.localizations,
    this.totalTax,
    Key? key,
  }) : super(key: key);

  final String? totalProducts,
      grandTotal,
      totalTax;
  final AppLocalizations? localizations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
      child: Container(
        color: Theme.of(context).cardColor,
        child: Theme(
          // This will remove top and bottom divider from expansion tile
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListTileTheme(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
            child: ExpansionTile(
              iconColor: Theme.of(context).colorScheme.primary,
              childrenPadding:
              const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
              initiallyExpanded: true,
              title:
                  Row(
                    children: [
                      Icon(Icons.local_activity,color: Theme.of(context).colorScheme.onPrimary,size: 22,),
                      SizedBox(width: 8,),
                      Text((localizations?.translate(AppStringConstant.priceDetails,) ?? "").toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
              children: <Widget>[
                _priceItem(
                    localizations?.translate(AppStringConstant.subtotal) ?? "",
                    totalProducts ?? "0.00",context),
                  _priceItem(localizations?.translate(AppStringConstant.tax) ?? "",
                      totalTax ?? "0.00",context),
                _priceItem(localizations?.translate(AppStringConstant.orderTotal) ?? "",
                    grandTotal ?? "0.00",context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceItem(String title, String price,BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(AppSizes.linePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13,fontWeight: FontWeight.normal)
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,

              price,
              style: TextStyle(
                fontWeight:  FontWeight.normal,
              ),
            )
          ],
        ),
      );
}