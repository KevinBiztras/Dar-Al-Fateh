


// ============ cart_icon_button.dart ============
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

const Color _emerald = Color(0xFF1B5E20);
const Color _sage = Color(0xFFB7C9A8);

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    required this.leadingIcon,
    required this.title,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.itemHeight,
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(color: _sage, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(leadingIcon, color: _emerald, size: 20),
            const SizedBox(width: AppSizes.linePadding),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _emerald,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}