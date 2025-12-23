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

// ignore_for_file: must_be_immutable

/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/screens/product/views/image_zoom_viewer.dart';

class ProductImages extends StatefulWidget {
  List<String> productImages;
  ProductImages(this.productImages, {Key? key}) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  final PageController _pageController = PageController(initialPage: 0);
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();

    // Auto scroll every 3 seconds
    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;

      final nextPage = _pageController.page!.toInt() + 1;

      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSizes.width/1.3,
          width: AppSizes.width/1.2,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final actualIndex = index % widget.productImages.length;

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ZoomImageView(
                      productImages: widget.productImages,
                      initialIndex: actualIndex,
                    ),
                  ));
                },
                child: Container(
                  color: Colors.white,
                  child: ImageView(
                    url: widget.productImages[actualIndex],
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              _currentPageNotifier.value =
                  index % widget.productImages.length;
            },
          ),
        ),

        // Page indicator
        Container(
          width: AppSizes.width,
          color: Theme.of(context).cardColor,
          child: Center(
            child: _buildCircularIndicator(_currentPageNotifier),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularIndicator(ValueNotifier<int> notifier) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor:
        Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.productImages.length,
        currentPageNotifier: notifier,
      ),
    );
  }
}

