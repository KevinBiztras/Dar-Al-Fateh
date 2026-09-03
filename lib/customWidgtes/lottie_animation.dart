

// ============ lottie_animation.dart ============
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
import 'package:lottie/lottie.dart';

const Color _emerald = Color(0xFF1B5E20);
const Color _gold = Color(0xFFF9A825);

Widget lottieAnimation(
  BuildContext context,
  String title,
  String subtitle,
  String buttonTitle,
  VoidCallback? callback, {
  String? lottiePath,
  IconData? icon,
}) {
  return Center(
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        width: AppSizes.width - 50,
        child: Column(
          children: [
            icon != null
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4EA),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: AppSizes.height / 7,
                      color: _emerald.withOpacity(0.5),
                    ),
                  )
                : Container(),
            if (icon != null) const SizedBox(height: AppSizes.mediumPadding),
            if (lottiePath != null)
              Lottie.asset(
                lottiePath,
                width: AppSizes.width / 1.8,
                height: AppSizes.width / 1.8,
                fit: BoxFit.fill,
                repeat: false,
              ),
            const SizedBox(height: AppSizes.mediumPadding),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: _emerald,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.all(AppSizes.linePadding)),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
            ),
            const Padding(padding: EdgeInsets.all(AppSizes.imageRadius)),
            if (buttonTitle != '')
              SizedBox(
                width: double.infinity,
                height: AppSizes.height / 18,
                child: ElevatedButton(
                  onPressed: callback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gold,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    buttonTitle,
                    style: const TextStyle(
                      color: _emerald,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
