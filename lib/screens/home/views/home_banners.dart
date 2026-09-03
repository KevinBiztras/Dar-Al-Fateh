

/*
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
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

  // ── Brand tokens ──────────────────────────────────────────────
  static const Color _emerald = Color(0xFF1A3C2B);
  static const Color _leafGreen = Color(0xFF4CAF78);
  static const Color _dotInactive = Color(0xFFB0BEC5);

  @override
  void initState() {
    super.initState();
    if (widget.enableAutoScroll) {
      _timer = Timer.periodic(
        const Duration(seconds: 3),
        //  (_) {
        //   final count = _effectiveCount;
        //   if (count == 0) return;
        //   _currentPageNotifier.value = (_currentPageNotifier.value + 1) % count;
        //   // _pageController.animateToPage(
        //   //   // keep virtual offset in sync
        //   //   _pageController.page!.round() + 1,
        //   //   duration: const Duration(milliseconds: 500),
        //   //   curve: Curves.easeInOut,
        //   // );
        // }
        (_) => _changeBanner(),
      );
    }
  }

  Future<void> _changeBanner() async {
    if (_isAnimating || !_pageController.hasClients) return;

    _isAnimating = true;

    // setState(() {
    //   _opacity = 0.20;
    // });

    // await Future.delayed(const Duration(milliseconds: 500));

    _pageController.jumpToPage(_pageController.page!.round() + 1);
    // await _pageController.animateToPage(
    //   _pageController.page!.round() + 1,
    //   duration: const Duration(milliseconds: 900),
    //   curve: Curves.easeInOutCubic,
    // );

    _currentPageNotifier.value =
        (_currentPageNotifier.value + 1) % _effectiveCount;

    // setState(() {
    //   // _opacity = 1;
    //   _currentPageNotifier.value =
    //       (_currentPageNotifier.value + 1) % _effectiveCount;
    // });

    _isAnimating = false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    _timer?.cancel();
    super.dispose();
  }

  int get _effectiveCount =>
      widget.itemCountOverride ?? widget.banners?.data?.length ?? 0;

  // double _opacity = 1.0;
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final itemCount = _effectiveCount;
    if (itemCount == 0) return const SizedBox.shrink();

    return Padding(
      // Outer breathing room from screen edges
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Hero card ────────────────────────────────────────
          _BannerCard(
            height: AppSizes.width / 1.45,
            pageController: _pageController,
            itemCount: itemCount,
            currentPageNotifier: _currentPageNotifier,
            itemBuilder: (context, circularIndex) {
              if (widget.itemBuilder != null) {
                return widget.itemBuilder!(context, circularIndex);
              }
              return _BannerSlide(
                data: widget.banners?.data?[circularIndex],
                onTap: () => _handleBannerClick(
                  widget.banners?.data?[circularIndex],
                  context,
                ),
              );
            },
            onPageChanged: (index) {
              _currentPageNotifier.value = index % itemCount;
            },
            // opacity: _opacity,
          ),

          const SizedBox(height: 12),

          // ── Pill indicator ───────────────────────────────────
          // Center(
          //   child: ValueListenableBuilder<int>(
          //     valueListenable: _currentPageNotifier,
          //     builder: (_, current, __) => _PillIndicator(
          //       count: itemCount,
          //       current: current,
          //       activeColor: _emerald,
          //       inactiveColor: _dotInactive,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  void _handleBannerClick(Data? banner, BuildContext context) {
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

// ─────────────────────────────────────────────────────────────────────────────
// Extracted: the outer card shell with shadow + clip
// ─────────────────────────────────────────────────────────────────────────────
class _BannerCard extends StatelessWidget {
  final double height;
  final PageController pageController;
  final int itemCount;
  final ValueNotifier<int> currentPageNotifier;
  final Widget Function(BuildContext, int) itemBuilder;
  final ValueChanged<int> onPageChanged;
  // final double opacity;

  const _BannerCard({
    required this.height,
    required this.pageController,
    required this.itemCount,
    required this.currentPageNotifier,
    required this.itemBuilder,
    required this.onPageChanged,
    // required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PageView.builder(
          controller: pageController,
          itemCount: null, // infinite scroll
          onPageChanged: onPageChanged,
          // itemBuilder: (ctx, index) => itemBuilder(ctx, index % itemCount),
          itemBuilder: (ctx, index) {
            return _AnimatedBannerWrapper(
              child: itemBuilder(ctx, index % itemCount),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Extracted: a single banner slide — image + frosted-glass bottom overlay
// ─────────────────────────────────────────────────────────────────────────────
class _BannerSlide extends StatelessWidget {
  final Data? data;
  final VoidCallback onTap;

  const _BannerSlide({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final url = data?.url ?? '';
    final isAsset = url.startsWith('assets/');

    final imageWidget = isAsset
        ? Image.asset(
            url,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        : ImageView(url: url, fit: BoxFit.cover, isBanner: true);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Full-bleed image ──────────────────────────────────
          // imageWidget,
          // TweenAnimationBuilder<double>(
          //   tween: Tween(begin: 1.08, end: 1.0),
          //   duration: const Duration(seconds: 4),
          //   curve: Curves.easeOutCubic,
          //   builder: (context, scale, child) {
          //     return Transform.scale(scale: scale, child: child);
          //   },
          //   child: imageWidget,
          // ),
           imageWidget,

          // ── Frosted gradient scrim at bottom ─────────────────
          // Gives depth and ensures any future text label is readable
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.45), Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Optional banner name label ────────────────────────
          if ((data?.bannerName ?? '').isNotEmpty)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                data!.bannerName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  shadows: [Shadow(blurRadius: 6, color: Colors.black54)],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Signature element: stretching-pill page indicator
// Active dot expands into a pill; inactive dots are tight circles.
// ─────────────────────────────────────────────────────────────────────────────
class _PillIndicator extends StatelessWidget {
  final int count;
  final int current;
  final Color activeColor;
  final Color inactiveColor;

  const _PillIndicator({
    required this.count,
    required this.current,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final bool isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _AnimatedBannerWrapper extends StatefulWidget {
  final Widget child;

  const _AnimatedBannerWrapper({required this.child});

  @override
  State<_AnimatedBannerWrapper> createState() => _AnimatedBannerWrapperState();
}

class _AnimatedBannerWrapperState extends State<_AnimatedBannerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scale;

  late Animation<double> opacity;

  // late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    opacity = Tween(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    scale = Tween(
      // begin: 1.08,
      begin: 1.04,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    // slide = Tween(
    //   begin: const Offset(0, .04),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child:
          // SlideTransition(
          //   position: slide,
          //   child: ScaleTransition(
          //     scale: scale,
          //     child: widget.child,
          //   ),
          // ),
          FadeTransition(
            opacity: opacity,
            child: ScaleTransition(scale: scale, child: widget.child),
          ),
    );
  }
}
