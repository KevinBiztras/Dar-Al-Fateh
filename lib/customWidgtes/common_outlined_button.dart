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

Widget commonButton(
  BuildContext context,
  VoidCallback onPressed,
  String text, {
  double? width,
  double? height,
  Widget? widget,
  Color? textColor,
  Color? backgroundColor,
  Color? borderSideColor,
  double borderRadius = 4,
}) {
  // Set smaller default sizes for width and height if not provided
  double buttonWidth =
      width ?? AppSizes.width * 0.6; // Decrease width (60% of the screen width)
  double buttonHeight = height ?? AppSizes.height / 18; // Decrease height

  return OutlinedButton(
    onPressed: onPressed,
    child:
        widget ??
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: textColor),
        ),
    style: OutlinedButton.styleFrom(
      side: borderSideColor != null ? BorderSide(color: borderSideColor) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      minimumSize: Size(
        (width != null) ? width : AppSizes.width/7,
        (height != null) ? height : AppSizes.height / 24,
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
