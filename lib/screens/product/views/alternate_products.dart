
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
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';

import '../../../constants/app_constants.dart';
import '../../../models/ProductScreenModel.dart';

class AlternateProductsList extends StatelessWidget {
  List<AlternativeProducts>? alternativeProducts;

  AlternateProductsList(this.alternativeProducts);

  @override
  Widget build(BuildContext context) {
    if ((alternativeProducts ?? []).isEmpty) return const SizedBox();

    final theme = Theme.of(context);
    final cardWidth = AppSizes.width * 0.40;
    final imageHeight = cardWidth * 0.75;

    return Container(
      color: theme.cardColor,
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate(AppStringConstant.alternateProducts) ??
                      'You May Also Like',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(
            height: imageHeight + 80,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: alternativeProducts?.length,
              itemBuilder: (context, index) {
                final data = alternativeProducts![index];
                return _productCard(data, context, cardWidth, imageHeight);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(
    AlternativeProducts product,
    BuildContext context,
    double cardWidth,
    double imageHeight,
  ) {
    final theme = Theme.of(context);
    final hasDiscount = (product.priceReduce ?? '').isNotEmpty;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(
          productPage,
          arguments: getProductDataMap(
            product.name ?? '',
            product.templateId.toString(),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                height: imageHeight,
                color: Colors.white,
                child: ImageView(
                  url: product.image,
                  fit: BoxFit.contain,
                  width: cardWidth,
                  height: imageHeight,
                ),
              ),

              // Product info
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            hasDiscount
                                ? product.priceReduce ?? ''
                                : product.priceUnit ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: theme.colorScheme.onPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (hasDiscount) ...[
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              product.priceUnit ?? '',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
