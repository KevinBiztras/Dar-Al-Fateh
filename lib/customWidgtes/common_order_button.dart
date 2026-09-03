

// ============ common_order_button.dart ============
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

const Color _emerald = Color(0xFF1B5E20);
const Color _gold = Color(0xFFF9A825);

Widget commonOrderButton(
  BuildContext context,
  AppLocalizations? _localizations,
  String amount,
  VoidCallback onPressed, {
  Color color = MobikulTheme.clientAccentColor,
  String title = AppStringConstant.proceed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 14,
          offset: const Offset(0, -4),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.mediumPadding,
      vertical: AppSizes.imageRadius,
    ),
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
                style: TextStyle(fontSize: 12.5, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: _emerald,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSizes.mediumPadding),
        Expanded(
          child: SizedBox(
            height: AppSizes.height / 18,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: _gold,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (_localizations?.translate(title) ?? "").toUpperCase(),
                    style: const TextStyle(
                      color: _emerald,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: _emerald,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
