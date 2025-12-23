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
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';

Future orderItemList(BuildContext context, List<OrderItems> items, AppLocalizations? _localizations){

  return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context){
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).cardColor,
                width: AppSizes.width,
                padding: const EdgeInsets.all( AppSizes.imageRadius ),
                margin: const EdgeInsets.only(bottom: AppSizes.imageRadius),
                child: Text((_localizations?.translate(AppStringConstant.chooseProduct) ?? "").toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

              ListView.builder(
                shrinkWrap:  true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      reviewBottomModalSheet(context, items[index].name ?? '', items[index].thumbNail ?? '', items[index].templateId ?? 0);
                    },
                    child: Container(
                      padding: const EdgeInsets.all( AppSizes.imageRadius),
                      margin: const EdgeInsets.only(bottom: AppSizes.imageRadius),
                      color: Theme.of(context).cardColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Image
                          ImageView(
                            url: items[index].thumbNail,
                            width: AppSizes.width / 4,
                          ),

                          const SizedBox(width: AppSizes.genericPadding),

                          Expanded(
                            child: Text(items[index].name ?? ''),
                          ),

                          // Edit button
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      }
  );
}