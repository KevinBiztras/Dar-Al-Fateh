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

import 'dart:async';
import 'dart:ui';

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
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/circle_page_indicator.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

class HomeBanners extends StatefulWidget {
  final HomepageDataList? banners;
  final int? itemCountOverride;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final bool enableAutoScroll;

  const HomeBanners(
    this.banners, {
    this.itemBuilder,
    this.itemCountOverride,
    this.enableAutoScroll = true,
    Key? key,
  }) : super(key: key);

  @override
  _HomeBannersState createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  final _pageController = PageController(initialPage: 1000);
  final _currentPageNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.enableAutoScroll) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        final count = _effectiveCount;
        if (count == 0) return;
        _currentPageNotifier.value = (_currentPageNotifier.value + 1) % count;

        _pageController.animateToPage(
          _currentPageNotifier.value,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _onPageChanged() {
    final count = _effectiveCount;
    if (count == 0) return;

    final currentPage = _pageController.page ?? 0;
    _currentPageNotifier.value = currentPage.round() % count;
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    _currentPageNotifier.dispose();
    _timer?.cancel();
    super.dispose();
    _timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //   final _localBanners = [
  //   'assets/images/bannerimage1.png',
  //   'assets/images/bannerimage2.png',
  //   'assets/images/bannerimage3.png',
  // ];

  @override
  Widget build(BuildContext context) {
    final itemCount = _effectiveCount;
    // final bannertemCount = _localBanners.length;

    if (itemCount == 0) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: AppSizes.width / 2,
        //   width: AppSizes.width.toDouble(),
        //   child: PageView.builder(
        //     controller: _pageController,
        //     // itemCount: widget.banners?.data?.length,
        //     itemCount: itemCount,
        //     itemBuilder: (BuildContext context, int index) {
        //       if(widget.itemBuilder !=null){
        //         return widget.itemBuilder!(context,index);
        //       }
        //       final data = widget.banners?.data?[index];
        //       return InkWell(
        //         onTap: () =>
        //             handleBannerClicks(widget.banners?.data?[index], context),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child:
        //               // ImageView(
        //               //   url:
        //               //       ((widget.banners?.data?[index].url != null) &&
        //               //           (widget.banners?.data?[index].url is String))
        //               //       ? (widget.banners?.data?[index].url ?? "")
        //               //       : "",
        //               //   fit: BoxFit.fill,
        //               //   isBanner: true,
        //               // ),
        //               // ImageView(
        //               //   url: data?.url??'',
        //               //   fit: BoxFit.fill,
        //               //   isBanner: true,
        //               // )
        //               Image.asset(
        //                 'assets/images/bannerimage1.png',
        //                 fit: BoxFit.fill,
        //               ),
        //         ),
        //       );
        //     },
        //     onPageChanged: (int index) {
        //       setState(() {
        //         _currentPageNotifier.value = index;
        //       });
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: AppSizes.width / 1.5,
            width: AppSizes.width.toDouble(),
            child: PageView.builder(
              controller: _pageController,
              // itemCount: widget.banners?.data?.length,
              itemCount: null,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifier.value = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                // To make it circular, we use modulo
                final circularIndex = index % itemCount;
          
                // if(widget.itemBuilder !=null){
                //   return widget.itemBuilder!(context,index);
                // }
                if (widget.itemBuilder != null) {
                  return widget.itemBuilder!(context, circularIndex);
                }
                final data = widget.banners?.data?[circularIndex];
          
                final url = data?.url ?? '';
                final isAsset = url.startsWith('assets/');
                final image = isAsset
                    ? Image.asset(url, fit: BoxFit.fill)
                    : ImageView(url: url, fit: BoxFit.fill, isBanner: true);
          
                return InkWell(
                  onTap: () => handleBannerClicks(
                    widget.banners?.data?[circularIndex],
                    context,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        // ImageView(
                        //   url:
                        //       ((widget.banners?.data?[index].url != null) &&
                        //           (widget.banners?.data?[index].url is String))
                        //       ? (widget.banners?.data?[index].url ?? "")
                        //       : "",
                        //   fit: BoxFit.fill,
                        //   isBanner: true,
                        // ),
                        // ImageView(
                        //   url: data?.url??'',
                        //   fit: BoxFit.fill,
                        //   isBanner: true,
                        // )
                        // Image.asset(
                        //   'assets/images/bannerimage1.png',
                        //   fit: BoxFit.fill,
                        // ),
                        image
                  ),
                );
              },
            ),
          ),
        ),
        Center(child: _buildCircularindicator(_currentPageNotifier)),
      ],
    );
  }

  int get _effectiveCount =>
      widget.itemCountOverride ?? widget.banners?.data?.length ?? 0;

  Widget _buildCircularindicator(_currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor:
            Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: _effectiveCount,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  void handleBannerClicks(Data? banner, BuildContext context) {
    if (banner?.bannerType == AppConstant.categoryTypeNotification) {
      Navigator.pushNamed(
        context,
        catalogPage,
        arguments: getCatalogMap(
          "",
          false,
          banner?.bannerName ?? "",
          customerId: banner?.id,
        ),
      );
    } else if (banner?.bannerType == AppConstant.productTypeNotification) {
      Navigator.pushNamed(
        context,
        productPage,
        arguments: getProductDataMap(
          banner?.bannerName ?? "",
          banner?.id.toString() ?? "",
        ),
      );
    } else if (banner?.bannerType == AppConstant.customTypeNotification) {
      Navigator.pushNamed(
        context,
        catalogPage,
        arguments: getCatalogMap(
          "",
          false,
          "Catalog",
          fromNotification: true,
          domain: banner?.domain ?? "",
        ),
      );
    }
  }
}
