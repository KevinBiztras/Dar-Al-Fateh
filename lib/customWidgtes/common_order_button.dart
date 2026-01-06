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
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../config/theme.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';

Widget commonOrderButton(BuildContext context, AppLocalizations? _localizations,
    String amount, VoidCallback onPressed,
    {Color color = MobikulTheme.clientAccentColor,
    String title = AppStringConstant.proceed}) {
  return Container(
    // height: 55,
    color: Theme.of(context).cardColor,
    padding: const EdgeInsets.all(AppSizes.imageRadius),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                _localizations?.translate(AppStringConstant.amountToBePaid) ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 13),
              ),
              const SizedBox(
                height: AppSizes.linePadding,
              ),
              Text(amount,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)
                  // ?.copyWith(fontSize: TextSizes.mediumTextSize),
                  )
            ],
          ),
        ),
        Expanded(
            child: commonButton(context, onPressed,
                (_localizations?.translate(title) ?? "").toUpperCase(),
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                backgroundColor: const Color.fromARGB(255, 252, 232, 51).withValues(alpha: 1),
            height: AppSizes.height / 20)

            // ElevatedButton(
            //   onPressed: onPressed,
            //   child: Text(
            //     (_localizations?.translate(title) ?? "")
            //         .toUpperCase(),
            //     style: const TextStyle(color: AppColors.white),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       elevation: 0,
            //       primary: color),
            // ),
            )
      ],
    ),
  );
}
