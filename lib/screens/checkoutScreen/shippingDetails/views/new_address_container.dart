
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

Widget addNewAddress(BuildContext context,String title, VoidCallback callback, ){
  return Padding(
    padding:  const EdgeInsets.all( AppSizes.imageRadius),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.onPrimary,width: 1.5),borderRadius: BorderRadius.circular(4)),
            child: InkWell(
              onTap: callback,
              child: Row(
                children: [
                 const Icon(
                    Icons.add,
                    size: 22,
                  ),
                  const SizedBox(
                    width: AppSizes.linePadding ,
                  ),
                  Text(title .toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12, fontWeight: FontWeight.bold))
                ],
              ),
            )),

      ],
    ),
  );
}