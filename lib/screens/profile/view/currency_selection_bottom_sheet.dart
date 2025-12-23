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

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_restart.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/screens/signin_signup/view/my_bottom_sheet.dart';
import 'package:hive/hive.dart';

void showCurrencyBottomSheet(BuildContext context, AppLocalizations? _localizations) {
  var availablePriceLists = AppSharedPref().getSplashData()?.allPricelists;
  var selectedCurrency = AppSharedPref().getAppCurrency();
  String splashBoxName = HiveConstants.getSplashModelBoxName();
  String homeBoxName = HiveConstants.getHomePageModelBoxName();
  if (availablePriceLists != null && availablePriceLists.isNotEmpty) {
    showMyModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Scaffold(
        appBar: commonToolBar(_localizations?.translate(AppStringConstant.currency) ?? '', context, isLeadingEnable: true),
        body: ListView.builder(
            itemCount: availablePriceLists.length,
            itemBuilder: (context, index) {
              var item = availablePriceLists[index];
              return InkWell(
                onTap: () {
                  if (selectedCurrency != item[0]) {
                    Hive.deleteBoxFromDisk(splashBoxName);
                    Hive.deleteBoxFromDisk(homeBoxName);
                    AppSharedPref().setAppCurrency(item[0]);
                    AppRestart.rebirth(context);
                    print('currency ---${item[0]}');
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.lightGray,
                            width: 0.5)
                    ),
                  ),
                  // color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(AppSizes.widgetSidePadding),
                  child: Text(
                    item[1],
                    style: selectedCurrency == item[0]
                        ? Theme.of(context).textTheme.headlineSmall
                        : null,
                  ),
                ),
              );
            }),
      ),
    );
  }
}