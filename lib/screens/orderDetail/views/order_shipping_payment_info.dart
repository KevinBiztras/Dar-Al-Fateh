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
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../models/OrderDetailModel.dart';
import '../../addressBook/views/address_item_card.dart';
import 'order_heading_view.dart';

Widget shippingPaymentInfo(BuildContext context,
    AppLocalizations? _localizations, OrderDetailModel? _orderModel) {
  return orderHeaderLayout(
      context,
      _localizations?.translate(AppStringConstant.shippingPaymentInfo) ?? "",
      Column(
        children: [
          addressItemWithHeading(
              context,
              _localizations?.translate(AppStringConstant.shippingAddress) ??
                  "",
              _orderModel?.shippingAddress ?? "",
              isElevated: false),
           Container(
             color: Theme.of(context).canvasColor,
            height: AppSizes.normalPadding,
             width: AppSizes.width,
          ),
          addressItemWithHeading(
              context,
              _localizations?.translate(AppStringConstant.billingAddress) ?? "",
              _orderModel?.billingAddress ?? "",
              isElevated: false),
        ],
      ));
}
