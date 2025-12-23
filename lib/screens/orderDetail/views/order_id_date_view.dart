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
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/file_download.dart';

Widget orderIdContainer(BuildContext context, OrderDetailModel? _orderModel, AppLocalizations? _localization) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.mediumPadding),
          topRight: Radius.circular(AppSizes.mediumPadding)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.mediumPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_localization?.translate(AppStringConstant.order)}${_orderModel?.name}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.lightGray),
            ),
            // if(_orderModel?.isOrderInvoiced ?? false)
            InkWell(
              onTap:(){
                print("object");
                DownloadFile().downloadPersonalData(
                    _orderModel?.downloadInvoice ?? "",
                  // "https://mobikulodoodemo.webkul.in/my/invoices/148?access_token=f8971094-668a-4c83-955a-a816bac21fc5&report_type=pdf&download=true",
                    "${_orderModel?.name}_INV.pdf",
                    context,
                   );
              },
              child: Container(
                color: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.all(AppSizes.normalPadding),
                  child:  Text( _localization?.translate(AppStringConstant.downloadInvoices)??"",style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.secondaryContainer, ),)),
            )
          ],
        ),
        const SizedBox(
          height: AppSizes.mediumPadding,
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
      ],
    ),
  );
}

Widget orderPlaceDateContainer(BuildContext context, OrderDetailModel? _orderModel, AppLocalizations? _localization) {
  return Container(
      color: Theme.of(context).cardColor,
      width: AppSizes.width,
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.mediumPadding, horizontal: AppSizes.imageRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _localization?.translate(AppStringConstant.placedOn)??"",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.lightGray),
              ),
              const SizedBox(
                height: AppSizes.linePadding,
              ),
              Text(
                _orderModel?.createDate ?? "",
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.linePadding,
                vertical: AppSizes.linePadding),
            color: AppColors.yellow,
            child: Text(
              _orderModel?.status ?? "".toUpperCase(),
              style: const TextStyle(color: AppColors.white),
            ),
          )
        ],
      ));
}