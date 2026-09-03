
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
    return Stack(
      children: [
        // Full-width image with subtle rounded bottom
        SizedBox(
          height: AppSizes.width * 0.9,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final actualIndex = index % widget.productImages.length;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ZoomImageView(
                        productImages: widget.productImages,
                        initialIndex: actualIndex,
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: ImageView(
                    url: widget.productImages[actualIndex],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              _currentPageNotifier.value = index % widget.productImages.length;
            },
          ),
        ),

        // Dot indicator overlaid at bottom of image
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Center(child: _buildCircularIndicator(_currentPageNotifier)),
        ),

        // Image count badge (top-right)
        if (widget.productImages.length > 1)
          Positioned(
            top: 12,
            right: 16,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (_, page, __) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${page + 1} / ${widget.productImages.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCircularIndicator(ValueNotifier<int> notifier) {
    return CirclePageIndicator(
      dotColor: Colors.white.withOpacity(0.5),
      selectedDotColor: Colors.white,
      itemCount: widget.productImages.length,
      currentPageNotifier: notifier,
    );
  }
}
