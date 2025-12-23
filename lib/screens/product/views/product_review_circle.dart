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

// ignore_for_file: prefer_typing_uninitialized_variables

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
import 'dart:math' as math;

import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../models/ReviewListModel.dart';

class ProductReviewCircle extends StatefulWidget {
  final List<ProductReviews>? productReviews;

  const ProductReviewCircle({super.key, this.productReviews});

  @override
  _ProductReviewCircleState createState() => _ProductReviewCircleState();
}

class _ProductReviewCircleState extends State<ProductReviewCircle> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> ratingCounts =
        calculateRatingCounts(widget.productReviews ?? []);

    return Stack(alignment: Alignment.center, children: [
      Center(
        child: CustomPaint(
          painter: OpenPainter(
            oneRating: ratingCounts[1] ?? 0,
            twoRating: ratingCounts[2] ?? 0,
            threeRating: ratingCounts[3] ?? 0,
            fourRating: ratingCounts[4] ?? 0,
            fiveRating: ratingCounts[5] ?? 0,
          ),
        ),
      ),
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ratingStar(_localizations?.translate(AppStringConstant.one) ?? '',
                  AppColors.red),
              ratingStar(_localizations?.translate(AppStringConstant.two) ?? '',
                  AppColors.lightRed),
              ratingStar(
                  _localizations?.translate(AppStringConstant.three) ?? '',
                  AppColors.yellow),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ratingStar(
                  _localizations?.translate(AppStringConstant.four) ?? '',
                  AppColors.orange),
              ratingStar(
                  _localizations?.translate(AppStringConstant.five) ?? '',
                  AppColors.green),
            ],
          ),
        ],
      )
    ]);
  }

  Widget ratingStar(String rating, Color color) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: (AppSizes.linePadding),
            vertical: (AppSizes.linePadding / 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              rating,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10),
            ),
            Icon(
              Icons.star,
              color: color,
              size: 10,
            )
          ],
        ));
  }
}

Map<int, int> calculateRatingCounts(List<ProductReviews> reviews) {
  Map<int, int> ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  for (ProductReviews i in reviews) {
    int rating = i.rating?.toInt() ?? 0;
    ratingCounts[rating] = (ratingCounts[rating] ?? 0) + 1;
  }
  return ratingCounts;
}

class OpenPainter extends CustomPainter {
  final oneRating;
  final twoRating;
  final threeRating;
  final fourRating;
  final fiveRating;
  double pi = math.pi;

  OpenPainter(
      {this.oneRating,
      this.threeRating,
      this.twoRating,
      this.fiveRating,
      this.fourRating});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 7;
    Rect myRect = Offset(-(AppSizes.width / 7.4), -(AppSizes.width / 7.4)) &
        Size(AppSizes.width / 3.5, AppSizes.width / 3.5);

    var paints = [
      Paint()
        ..color = AppColors.red
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
      Paint()
        ..color = AppColors.lightRed
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
      Paint()
        ..color = AppColors.yellow
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
      Paint()
        ..color = AppColors.orange
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
      Paint()
        ..color = AppColors.green
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke,
    ];

    List<MapEntry<int, Paint>> ratingEntries = [
      MapEntry(oneRating, paints[0]),
      MapEntry(twoRating, paints[1]),
      MapEntry(threeRating, paints[2]),
      MapEntry(fourRating, paints[3]),
      MapEntry(fiveRating, paints[4]),
    ];

    ratingEntries.sort((a, b) => b.key.compareTo(a.key));

    int totalRatings =
        oneRating + twoRating + threeRating + fourRating + fiveRating;

    double startAngle = 0;

    for (var entry in ratingEntries) {
      if (entry.key == 0) continue; // Skip if no ratings for this segment

      double proportion = entry.key / totalRatings;
      double sweepAngle = getRadians(proportion);

      canvas.drawArc(myRect, startAngle, sweepAngle, false, entry.value);
      startAngle += sweepAngle;
    }
  }

  double getRadians(double value) {
    return (360 * value) * pi / 180;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
