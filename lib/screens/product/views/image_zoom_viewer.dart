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
import 'package:flutter_project_structure/constants/menu_images.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/image_view.dart';


class ZoomImageView extends StatefulWidget {
  ZoomImageView({super.key, this.productImages,this.initialIndex });
  List<String>? productImages;
  int? initialIndex;

  @override
  _ZoomImageViewState createState() => _ZoomImageViewState();
}

class _ZoomImageViewState extends State<ZoomImageView> {
  TapDownDetails? _doubleTapDetails;
  final _transformationController = TransformationController();
  late PageController _pageController;
  late ValueNotifier<int> _currentPageNotifier;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex ?? 0);
    _currentPageNotifier = ValueNotifier<int>(widget.initialIndex ?? 0);
  }

  double? imageSize;
  @override
  Widget build(BuildContext context) {
    imageSize ??= (AppSizes.width / 4);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.extraPadding),
                  child: Image.asset(
                    AppImages.cancelIcon,
                    width: AppSizes.extraPadding,
                    height: AppSizes.extraPadding,
                    color: (Theme.of(context).brightness == Brightness.light) ? AppColors.black : AppColors.white,
                  ),
                )),
            const SizedBox(height: AppSizes.extraPadding,),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.productImages?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onDoubleTapDown: _handleDoubleTapDown,
                    onDoubleTap: _handleDoubleTap,
                    child: ImageView(
                      url: widget.productImages?[index],
                    ),
                  );
                },
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                },
              ),
            ),
            Center(child: _buildCircularIndicator(_currentPageNotifier)),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: AppSizes.marginFive,vertical:AppSizes.spacingDefault ),
            //   child: SizedBox(
            //     height: (AppSizes.width / 4),
            //     child: ListView.builder(
            //         physics: const ClampingScrollPhysics(),
            //         shrinkWrap: true,
            //         scrollDirection: Axis.horizontal,
            //         itemCount: widget.productImages?.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return GestureDetector(
            //             onTap: () {
            //               //todo
            //               setState(() {
            //                 _pageController = PageController(initialPage: index);
            //               });
            //             },
            //             child: ImageView(
            //               url: widget.productImages?[index].thumb,
            //               width: imageSize!,
            //               height: imageSize!,
            //               fit: BoxFit.fill,
            //             ),
            //           );
            //         }),
            //   ),
            // )

          ],
        ),
      ),
    );
  }
  Widget _buildCircularIndicator(_currentPageNotifier){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor: Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.productImages?.length,
        currentPageNotifier: _currentPageNotifier,
        productImages: widget.productImages,
        onPageSelected: (int index) {
          _currentPageNotifier.value = index;
          setState(() {
            _pageController.animateToPage(index,curve: Curves.ease,duration: Duration(milliseconds: 300));
          });
        },
      ),
    );

  }

  void _handleDoubleTapDown(TapDownDetails details) {
    print('handleDioubletabdown ');
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {

    print('handleDiouble click');
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails?.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
      ..translate(-position!.dx, -position.dy)
      ..scale(2.0); // Fox a 2x zoom
    }
  }
}
