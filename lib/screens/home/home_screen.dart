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
      appBar: commonAppBar(
        // _localizations?.translate(AppStringConstant.APPNAME) ?? '',
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
              child: const Icon(Icons.search),
            ),
          ),
          IconButton(
            onPressed: () {
              notificationBottomModelSheet(context);
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, currentState) {
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
                        color: Theme.of(context).colorScheme.onPrimary,
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
                        child: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate(AppStringConstant.noItems) ??
                              "",
                          style: Theme.of(context).textTheme.titleLarge,
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

  // Widget _layout(List<HomepageDataList> data) {
  //   List<Widget> x = [];
  //   for (var val in data) {
  //     if (val.type == "featured_category" && (val.data?.isNotEmpty ?? false)) {
  //       x.add(
  //         HomeFeaturedCategories(
  //           val,
  //           val.featuredCategoryViewType,
  //           homePageData?.categories,
  //         ),
  //       );
  //     } else if (val.type == "banner" && (val.data?.isNotEmpty ?? false)) {
  //       x.add(HomeBanners(val));
  //     } else if (val.type == "slider") {
  //       x.add(
  //         HomeCollection(
  //           products: val.data ?? [],
  //           postWishlistClick: postWishlistClick,
  //         ),
  //       );
  //     }
  //   }
  //   x.add(const RecentView());
  //   x.add(buildReachBottomView());
  //   return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: x);
  // }
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
                final imageWidget = isAsset
                    ? Image.asset(thumb, fit: BoxFit.cover)
                    : Image.network(
                        thumb,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Image.asset('assets/images/cabbage.png'),
                      );
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      productPage,
                      arguments: getProductDataMap(
                        product.name ?? '',
                        (product.templateId ?? product.productId ?? '')
                            .toString(),
                      )..[productDataKey] = product,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Expanded(child: imageWidget),
                        // Row(
                        //   children: [SizedBox(width: 10,),
                        //     InkWell(child: Text('View all',selectionColor: Colors.red,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 6, 76, 133)),),onTap: (){},),
                        //   ],
                        // ),
                        SizedBox(width: 150, height: 150, child: imageWidget),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            product.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Expanded(
                          child: Text(
                            product.priceUnit ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 2),
                        Expanded(
                          child:
                              //  ElevatedButton(
                              //   onPressed: () {},
                              //   style: ElevatedButton.styleFrom(
                              //     padding: const EdgeInsets.symmetric(horizontal: 8),
                              //   ),
                              //   child: const Text(
                              //     'View Product',
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      productPage,
                                      arguments: getProductDataMap(
                                        product.name ?? '',
                                        (product.templateId ??
                                                product.productId ??
                                                '')
                                            .toString(),
                                      )..[productDataKey] = product,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 2,
                                    ), // Adjust padding for better feel
                                    shape: RoundedRectangleBorder(
                                      // Rounded corners for a modern look
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ), // You can adjust this for more or less rounded corners
                                    ),
                                    elevation: 5, // Slight shadow for depth
                                    backgroundColor: Colors
                                        .transparent, // Remove the solid background color to apply gradient
                                    side: BorderSide(
                                      color: Colors.transparent,
                                    ), // Remove border if you want a cleaner look
                                    shadowColor: Colors.black.withOpacity(
                                      0.2,
                                    ), // Soft shadow color
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        // Apply gradient
                                        colors: [
                                          Colors.blue,
                                          Colors.purple,
                                        ], // Gradient color range
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ), // Match the button's border radius
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'View Product',
                                        style: TextStyle(
                                          fontSize:
                                              16, // Larger font size for better readability
                                          fontWeight: FontWeight
                                              .bold, // Bold text for emphasis
                                          color: Colors
                                              .white, // Text color that stands out against the gradient
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
    }

    // Desired order: product slider(s), categories, then banners.
    final List<Widget> x = [
      ...bannerWidgets,
      ...categoryWidgets,
      // ...collectionWidgets,
      ...sliderWidgets,
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
            margin: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
            padding: const EdgeInsets.only(
              top: AppSizes.sidePadding,
              bottom: (AppSizes.sidePadding + AppSizes.sidePadding),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${AppLocalizations.of(context)?.translate(AppStringConstant.reachedBottom)}",
                ),
                TextButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4f9ff9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_up,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSizes.mediumPadding),
                      Text(
                        "${AppLocalizations.of(context)?.translate(AppStringConstant.backToTop)}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF4f9ff9),
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

  //=========Handle Deep Linking=========//
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

  void postWishlistClick() {
    setState(() {
      isFromPagination = true;
      offset = 0;
    });
    homePageBloc?.add(HomeScreenDataFetchEvent(offset));
    // final HiveService hiveService = HiveService();
    // String homeBoxName = HiveConstants.getHomePageModelBoxName();
    // homePageBloc?.repository
    //     ?.callApiAndUpdateHiveDB(hiveService, homeBoxName, false)
    //     .then((value) {
    //   homePageBloc?.add(HomeScreenDataFetchEvent());
    // });
    // homePageBloc?.repository
    //     ?.callApiAndUpdateHiveDB(hiveService, homeBoxName, false)
    //     .then((value) {
    //   homePageBloc?.add(HomeScreenDataFetchEvent());
    // });
  }

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
                      Navigator.pop(context); // Close dialog
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
    // Check: total 2 dots and 3 parts
    final regex = RegExp(r'^\d+\.\d+\.\d+$');
    return regex.hasMatch(version);
  }
}
