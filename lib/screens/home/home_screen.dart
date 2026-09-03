

// ------------------------

/*
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 */

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/helper/push_notifications_manager.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/views/home_banners.dart';
import 'package:flutter_project_structure/screens/home/views/home_collection_view.dart';
import 'package:flutter_project_structure/screens/home/views/home_featured_categories.dart';
import 'package:flutter_project_structure/screens/home/views/recent_view.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helper/LocalDb/floor/database.dart';
import '../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../main.dart';

// ── Brand tokens ───────────────────────────────────────────────────────────
class _HS {
  static const Color emerald = Color(0xFF1A3C2B);
  static const Color leafGreen = Color(0xFF4CAF78);
  static const Color bgPage = Color(0xFFF5F8F5);
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFF4CAF78);
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  _HomeScreenState state = _HomeScreenState();

  @override
  _HomeScreenState createState() {
    return state = _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc? homePageBloc;
  AppLocalizations? _localizations;
  bool isLoading = true;
  HomePageData? homePageData;
  List<HomepageDataList>? homepageDataList;
  int offset = 0;
  List<RecentProduct>? _recentProducts;
  bool isFromPagination = false;
  bool _showUpgradeAlert = false;
  final ScrollController _scrollController = ScrollController();
  String? keyVersion;

  @override
  void initState() {
    if (Platform.isAndroid) {
      keyVersion = AppSharedPref().getSplashData()?.androidVersion ?? "";
    } else if (Platform.isIOS) {
      keyVersion = AppSharedPref().getSplashData()?.iOSVersion ?? "";
    }

    if (isValidVersionFormat(keyVersion ?? "")) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkVersionAndUpdate(keyVersion);
      });
    } else {
      print("❌ Invalid version format in key: 1.0.0");
    }

    homePageBloc = context.read<HomeScreenBloc>();
    homePageBloc?.add(HomeScreenDataFetchEvent(offset));
    PushNotificationsManager().checkInitialMessage(context);
    _scrollController.addListener(() {
      paginationFunction();
    });

    fetchRecentProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    checkForDeepLink().then((value) => print("deep linking-->$value"));

    if (_showUpgradeAlert) {
      return UpgradeAlert(
        showReleaseNotes: false,
        upgrader: Upgrader(
          debugDisplayAlways: false,
          languageCode: AppSharedPref().getAppLanguage()?.split("_")[0] ?? "en",
          durationUntilAlertAgain: const Duration(seconds: 0),
        ),
        showLater: false,
        showIgnore: false,
        dialogStyle: UpgradeDialogStyle.cupertino,
        cupertinoButtonTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: _buildUI(),
      );
    }

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      // Warm sage background — gives cards visual lift
      backgroundColor: _HS.bgPage,

      appBar: commonAppBar(
        'Dar Al Fateh',
        context,
        isHomeEnable: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchPage);
            },
            icon: Semantics(
              identifier: 'search_icon',
              child: const Icon(Icons.search, color: Colors.green),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, wishlist);
            },
            icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
          ),
        ],
      ),

      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, currentState) {
          // ── State logic: 100% unchanged from original ──────────────────
          if (currentState is HomeScreenInitial) {
            if (!isFromPagination) {
              isLoading = true;
            }
          } else if (currentState is HomeScreenSuccess ||
              currentState is HomeScreenSuccessCache) {
            if (currentState is HomeScreenSuccessCache) {
              homePageData = currentState.homePageData;
              homepageDataList = currentState.homePageData?.homepageDataList;
              if (AppSharedPref().getAppCurrency() == null) {
                AppSharedPref().setAppCurrency(
                  currentState.homePageData!.defaultPricelist![0],
                );
              }
            } else if (currentState is HomeScreenSuccess) {
              if (offset == 0) {
                homePageData = currentState.homePageData;
                homepageDataList = currentState.homePageData?.homepageDataList;
              } else {
                homePageData = currentState.homePageData;
                homepageDataList?.addAll(
                  currentState.homePageData?.homepageDataList ?? [],
                );
              }
              AppSharedPref().setWishlistData(
                currentState.homePageData!.wishlist,
              );
              AppSharedPref().compareAvailability(
                currentState.homePageData?.addons?.websiteSaleComparison ??
                    false,
              );
              if (AppSharedPref().getAppCurrency() == null) {
                AppSharedPref().setAppCurrency(
                  currentState.homePageData!.defaultPricelist![0],
                );
              }
            }
            AppSharedPref().setGuestCartCount(homePageData?.cartCount ?? 0);
            isLoading = false;
            isFromPagination = false;
          } else if (currentState is HomeScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }

          return WillPopScope(
            onWillPop: () async {
              homePageBloc?.add(HomeScreenDataFetchEvent(offset));
              return true;
            },
            child: Stack(
              children: [
                (homePageData?.homepageDataList?.isNotEmpty ?? false) ||
                        (_recentProducts != null)
                    ? RefreshIndicator(
                        color: _HS.emerald,
                        backgroundColor: _HS.cardSurface,
                        onRefresh: () {
                          setState(() {
                            isFromPagination = true;
                            offset = 0;
                          });
                          return Future.delayed(Duration.zero).then((value) {
                            homePageBloc?.add(HomeScreenDataFetchEvent(offset));
                          });
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: _layout(homepageDataList ?? []),
                        ),
                      )
                    : isLoading
                    ? Loader()
                    : Center(
                        child: _EmptyHomeState(
                          message:
                              AppLocalizations.of(
                                context,
                              )?.translate(AppStringConstant.noItems) ??
                              "",
                        ),
                      ),
                Visibility(visible: isFromPagination, child: Loader()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _layout(List<HomepageDataList> data) {
    final List<Widget> bannerWidgets = [];
    final List<Widget> categoryWidgets = [];
    final List<Widget> sliderWidgets = [];
    final List<Widget> collectionWidgets = [];

    for (var val in data) {
      if (val.type == "banner" && (val.data?.isNotEmpty ?? false)) {
        bannerWidgets.add(HomeBanners(val));
      } else if (val.type == "featured_category" &&
          (val.data?.isNotEmpty ?? false)) {
        categoryWidgets.add(
          HomeFeaturedCategories(
            val,
            val.featuredCategoryViewType,
            homePageData?.categories,
          ),
        );
      } else if (val.type == "slider" && (val.data?.isNotEmpty ?? false)) {
        final List<Products> products =
            val.data
                ?.expand((d) => d.products ?? const <Products>[])
                .toList() ??
            [];

        collectionWidgets.add(
          HomeCollection(
            products: val.data ?? [],
            postWishlistClick: postWishlistClick,
          ),
        );

        if (products.isNotEmpty) {
          sliderWidgets.add(
            HomeBanners(
              val,
              enableAutoScroll: false,
              itemCountOverride: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final thumb = product.thumbNail ?? '';
                final isAsset = thumb.startsWith('assets/');
                // Beautiful product card — replaces raw SizedBox layout
                return _SliderProductCard(
                  product: product,
                  index: index,
                  thumb: thumb,
                  isAsset: isAsset,
                );
              },
            ),
          );
        }
      }
    }

    // Ordering: banners → categories → product sliders → trust badges → CTA → footer
    final List<Widget> x = [
      ...bannerWidgets,
      ...categoryWidgets,
      ...sliderWidgets,
      // ── Trust badges section (placeholder from reference image) ──
      const _TrustBadgesSection(),
      // ── "Join our Private Circle" CTA (placeholder) ──────────────
      const _PrivateCircleCTA(),
      buildReachBottomView(),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: x);
  }

  void fetchRecentProducts() async {
    _recentProducts = await (await AppDatabase.getDatabase()).recentProductDao
        .getProducts();
    _recentProducts = _recentProducts?.reversed.toList();
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildReachBottomView() {
    return (homePageData?.homepageDataList?.isNotEmpty ?? false) ||
            (_recentProducts != null && (_recentProducts?.isNotEmpty ?? false))
        ? Container(
            width: AppSizes.width.toDouble(),
            margin: const EdgeInsets.only(top: 8, bottom: 32),
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Leaf divider — natural end-of-feed marker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: _HS.leafGreen.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.eco_outlined,
                          size: 16,
                          color: _HS.leafGreen.withOpacity(0.55),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: _HS.leafGreen.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  "${AppLocalizations.of(context)?.translate(AppStringConstant.reachedBottom)}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: _HS.textSecondary,
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 14),

                // Back-to-top — brand emerald circle with glow shadow
                TextButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: _HS.emerald,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _HS.emerald.withOpacity(0.35),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${AppLocalizations.of(context)?.translate(AppStringConstant.backToTop)}",
                        style: const TextStyle(
                          color: _HS.emerald,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget viewAllButton() {
    return ElevatedButton(onPressed: () {}, child: Text('data'));
  }

  // ── Deep link — unchanged ──────────────────────────────────────────────────
  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future<String> checkForDeepLink() async {
    try {
      if (Platform.isAndroid) {
        var data = await methodChannel.invokeMethod('initialLink');
        if (data.toString().contains("product")) {
          var splitData = data.toString().split("-");
          Navigator.of(context).pushNamed(
            productPage,
            arguments: getProductDataMap("", splitData.last),
          );
        }
        return data;
      } else if (Platform.isIOS) {
        var data = await methodChannel.invokeMethod('uni_links/events');
        if (data.toString().contains("product")) {
          var splitData = data.toString().split("-");
          Navigator.of(context).pushNamed(
            productPage,
            arguments: getProductDataMap("", splitData.last),
          );
        }
        return data;
      } else {
        return 'OS NOT SUPPORTED';
      }
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  // ── Wishlist — unchanged ───────────────────────────────────────────────────
  void postWishlistClick() {
    setState(() {
      isFromPagination = true;
      offset = 0;
    });
    homePageBloc?.add(HomeScreenDataFetchEvent(offset));
  }

  // ── Pagination — unchanged ─────────────────────────────────────────────────
  void paginationFunction() {
    if (!isFromPagination &&
        _scrollController.hasClients &&
        _scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (homePageData?.homepageDataCount ?? 0) != homepageDataList?.length) {
      if ((offset + 5) < (homePageData?.homepageDataCount ?? 0)) {
        offset += 5;
        setState(() {
          isFromPagination = true;
          homePageBloc?.emit(HomeScreenInitial());
          homePageBloc?.add(HomeScreenDataFetchEvent(offset));
        });
      }
    }
  }

  // ── Version check — unchanged ──────────────────────────────────────────────
  Future<void> checkVersionAndUpdate(String? keyVersion) async {
    String appVersion = AppSharedPref().getReleaseVersion();
    List<int> app = appVersion.split('.').map(int.parse).toList();
    List<int> key = keyVersion?.split('.').map(int.parse).toList() ?? [];
    for (int i = 0; i < 3; i++) {
      if (key[i] > app[i]) {
        try {
          await Upgrader().initialize();
          setState(() {
            _showUpgradeAlert = true;
          });
        } on PlatformException catch (e) {
          if (e.code == 'TASK_FAILURE' && e.message?.contains('-6') == true) {
            showDialog(
              context: navigatorKey.currentContext!,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text(
                  _localizations?.translate(
                        AppStringConstant.updateAvailable,
                      ) ??
                      '',
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _localizations?.translate(
                            AppStringConstant.updateAvailableMessage,
                          ) ??
                          '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      _localizations?.translate(AppStringConstant.updateNow) ??
                          '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                actions: [
                  commonButton(
                    context,
                    () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      String url = '';
                      if (Platform.isAndroid) {
                        url =
                            'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';
                      } else if (Platform.isIOS) {
                        url =
                            'https://apps.apple.com/app/id${packageInfo.packageName}';
                      } else {
                        print("❌ Unsupported platform");
                        return;
                      }
                      final Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        bool launched = await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        if (!launched) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.inAppBrowserView,
                          );
                        }
                      } else {
                        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
                      }
                    },
                    _localizations?.translate(AppStringConstant.update) ?? '',
                  ),
                ],
              ),
            );
          }
        }
        return;
      } else if (key[i] < app[i]) {
        return;
      }
    }
    print("Versions are equal. No update needed.");
  }

  bool isValidVersionFormat(String version) {
    final regex = RegExp(r'^\d+\.\d+\.\d+$');
    return regex.hasMatch(version);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SliderProductCard
// Replaces the broken inline SizedBox(150×150) + three Expanded itemBuilder.
// Uses Expanded flex to fill whatever height HomeBanners provides.
// ─────────────────────────────────────────────────────────────────────────────
class _SliderProductCard extends StatelessWidget {
  final Products product;
  final int index;
  final String thumb;
  final bool isAsset;

  const _SliderProductCard({
    required this.product,
    required this.index,
    required this.thumb,
    required this.isAsset,
  });

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget = isAsset
        ? Image.asset(thumb, fit: BoxFit.contain)
        : Image.network(
            thumb,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                Image.asset('assets/images/cabbage.png', fit: BoxFit.contain),
          );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          productPage,
          arguments: getProductDataMap(
            product.name ?? '',
            (product.templateId ?? product.productId ?? '').toString(),
          )..[productDataKey] = product,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: _HS.cardSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _HS.cardBorder, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image top
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  color: const Color(0xFFF5F5F5),
                  padding: const EdgeInsets.all(10),
                  child: imageWidget,
                ),
              ),
            ),

            // Info + button bottom
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _HS.textPrimary,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      product.priceUnit ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _HS.emerald,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          productPage,
                          arguments: getProductDataMap(
                            product.name ?? '',
                            (product.templateId ?? product.productId ?? '')
                                .toString(),
                          )..[productDataKey] = product,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _HS.emerald,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _EmptyHomeState — replaces the bare Text widget in the empty branch
// ─────────────────────────────────────────────────────────────────────────────
class _EmptyHomeState extends StatelessWidget {
  final String message;
  const _EmptyHomeState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFA5D6A7), width: 2),
            ),
            child: const Icon(Icons.eco_outlined, size: 34, color: _HS.emerald),
          ),
          const SizedBox(height: 18),
          Text(
            message.isNotEmpty ? message : 'Nothing here yet',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _HS.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pull down to refresh',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: _HS.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _TrustBadgesSection — matches the 4-icon trust strip in the reference image
// (PLACEHOLDER: dummy data used; clearly commented)
// ─────────────────────────────────────────────────────────────────────────────
class _TrustBadgesSection extends StatelessWidget {
  const _TrustBadgesSection();

  // PLACEHOLDER: trust badge data — replace with real copy as needed
  static const List<_BadgeItem> _badges = [
    _BadgeItem(icon: Icons.eco_outlined, label: 'FarmFresh'),
    _BadgeItem(icon: Icons.verified_outlined, label: 'Quality\nGuaranteed'),
    _BadgeItem(icon: Icons.local_shipping_outlined, label: 'Same\nDelivery'),
    _BadgeItem(icon: Icons.spa_outlined, label: 'Nature\nInspired'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _badges.map((b) => _TrustBadge(item: b)).toList(),
      ),
    );
  }
}

class _BadgeItem {
  final IconData icon;
  final String label;
  const _BadgeItem({required this.icon, required this.label});
}

class _TrustBadge extends StatelessWidget {
  final _BadgeItem item;
  const _TrustBadge({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: Icon(item.icon, color: const Color(0xFF1A3C2B), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          item.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1E1E),
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _PrivateCircleCTA — matches the dark green "Join our Private Circle" banner
// in the reference image (PLACEHOLDER section — replace copy/action as needed)
// ─────────────────────────────────────────────────────────────────────────────
class _PrivateCircleCTA extends StatelessWidget {
  const _PrivateCircleCTA();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A3C2B), // brand emerald dark
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3C2B).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Leaf icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.spa_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 14),

          // Heading
          const Text(
            'Join our Private Circle',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),

          // Sub-copy — PLACEHOLDER
          const Text(
            'Get exclusive deals, early access to seasonal\nproducts and members-only offers.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 20),

          // CTA button — PLACEHOLDER action
          ElevatedButton(
            onPressed: () {
              // TODO: navigate to membership / subscription page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF9A825), // saffron gold accent
              foregroundColor: const Color(0xFF1A3C2B),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Join Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
