
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

AppBar commonToolBar(String heading, BuildContext context,
    { bool isElevated = true, bool isLeadingEnable = false}) {
  return AppBar(
    leading: isLeadingEnable ? IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.clear)) : null,
    elevation: isElevated ? null : 0,
    title: Text(
      heading,
      // style: Theme.of(context).textTheme.displaySmall?.copyWith(),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}
