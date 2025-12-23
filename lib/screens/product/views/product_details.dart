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

// ignore_for_file: must_be_immutable

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
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

class ProductDetailsView extends StatefulWidget {
  String? description;

  ProductDetailsView(this.description, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  AppLocalizations? _localizations;
  bool? isExpanded = false;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: AppSizes.normalPadding),
      child: ExpansionTile(
        showTrailingIcon: true,
          iconColor: Theme.of(context).textTheme.bodyLarge?.color,
        childrenPadding: const EdgeInsets.only(

            left: AppSizes.normalPadding/2,
            right: AppSizes.normalPadding/2,
            bottom: AppSizes.normalPadding/2),

        initiallyExpanded: (widget.description ?? '' ) != "" ? true : false,
          tilePadding: const EdgeInsets.symmetric(horizontal:AppSizes.normalPadding),
          title: Text(
              _localizations?.translate(AppStringConstant.details) ?? '',
              style: Theme.of(context).textTheme.titleSmall),
          trailing:isExpanded==true? const Icon(Icons.keyboard_arrow_up):const Icon(Icons.keyboard_arrow_down),
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          children:<Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.description ?? '',
                    style: Theme.of(context).textTheme.bodyLarge)
                // ProductsWebView(widget.description ?? '')
              ],
            ),
          ]),
    );
  }
}
