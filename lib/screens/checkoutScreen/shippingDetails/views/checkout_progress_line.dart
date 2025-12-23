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

import '../../../../constants/app_constants.dart';


Widget checkoutProgressLine(bool isFromShipping, BuildContext context){
  return Row(
    children: [
      Container(
        height: AppSizes.normalPadding / 2,
        width: AppSizes.width / 2 ,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      Container(
        height: AppSizes.normalPadding / 2,
        width: AppSizes.width / 2,
        color: isFromShipping ? AppColors.lightGray : Theme.of(context).colorScheme.onPrimary,
      )
    ],
  );
}