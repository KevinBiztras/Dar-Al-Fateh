
// ============ price_details.dart ============
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

const Color _emerald = Color(0xFF1B5E20);
const Color _leafGreen = Color(0xFF2E7D32);
const Color _sage = Color(0xFFB7C9A8);
const Color _gold = Color(0xFFF9A825);

class PriceDetails extends StatelessWidget {
  const PriceDetails({
    this.grandTotal,
    this.totalProducts,
    this.localizations,
    this.totalTax,
    Key? key,
  }) : super(key: key);

  final String? totalProducts, grandTotal, totalTax;
  final AppLocalizations? localizations;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.mediumPadding,
          ),
          child: ExpansionTile(
            iconColor: _emerald,
            childrenPadding: const EdgeInsets.fromLTRB(
              AppSizes.mediumPadding,
              0,
              AppSizes.mediumPadding,
              AppSizes.mediumPadding,
            ),
            initiallyExpanded: true,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3DA),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: _gold,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  (localizations?.translate(AppStringConstant.priceDetails) ??
                          "")
                      .toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: _emerald,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            children: <Widget>[
              _priceItem(
                localizations?.translate(AppStringConstant.subtotal) ?? "",
                totalProducts ?? "0.00",
                context,
              ),
              _priceItem(
                localizations?.translate(AppStringConstant.tax) ?? "",
                totalTax ?? "0.00",
                context,
              ),
              Divider(color: _sage.withOpacity(0.4), height: 20),
              _priceItem(
                localizations?.translate(AppStringConstant.orderTotal) ?? "",
                grandTotal ?? "0.00",
                context,
                isTotal: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceItem(
    String title,
    String price,
    BuildContext context, {
    bool isTotal = false,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 14.5 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? _emerald : Colors.grey[700],
          ),
        ),
        Text(
          price,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 16 : 13.5,
            color: isTotal ? _leafGreen : Colors.black87,
          ),
        ),
      ],
    ),
  );
}
