/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/splash/bloc/splash_screen_bloc.dart';

import '../../../constants/arguments_map.dart';
import '../../../main.dart';
import '../../../models/walkThroughModel.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  bool isLoading = true;

  SplashScreenModel? splashScreenModel;

  SplashScreenBloc? splashScreenBloc;

  WalkThroughModel? walkViewThroughModel;

  @override
  void initState() {
    splashScreenBloc = context.read<SplashScreenBloc>();
    splashScreenBloc?.add(SplashScreenDataFetchEvent());
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<SplashScreenBloc, SplashScreenState>(
  //     builder: (BuildContext context, state) {
  //       if (state is SplashScreenInitial) {
  //         isLoading = true;
  //       } else if (state is SplashScreenSuccess) {
  //         splashScreenBloc?.add(const WalkThroughFetchEvent());
  //         isLoading = false;
  //         splashScreenModel = state.splashScreenModel;
  //         setApplicationData(context);
  //       } else if (state is SplashScreenError) {
  //         isLoading = false;
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           AlertMessage.showError(state.message ?? '', context);
  //         });
  //       } else if (state is WalkThroughSuccess) {
  //         isLoading = false;
  //         walkViewThroughModel = state.model;

  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           AppSharedPref().getIfLogin() ?? false
  //               ? Navigator.pushReplacementNamed(context, navBar, arguments: 0)
  //               : splashScreenModel?.allowWalkThrough ?? false
  //               ? AppSharedPref().showWalkThrough()
  //                     ? Navigator.pushReplacementNamed(
  //                         context,
  //                         walkThrough,
  //                         arguments: walkViewThroughModel,
  //                       )
  //                     : splashScreenModel?.allowGuestCheckout ?? false
  //                     ? Navigator.pushReplacementNamed(
  //                         context,
  //                         navBar,
  //                         arguments: 0,
  //                       )
  //                     : Navigator.pushReplacementNamed(
  //                         context,
  //                         loginSignup,
  //                         arguments: true,
  //                       )
  //               : Navigator.pushReplacementNamed(
  //                   context,
  //                   loginSignup,
  //                   arguments: true,
  //                 );
  //         });
  //       }
  //       // else if (state is WalkThroughError) {
  //       //   isLoading = false;
  //       //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //       //     AlertMessage.showError(state.message, context);
  //       //   });
  //       // }
  //       else if (state is WalkThroughError) {
  //         isLoading = false;
  //         // Force go to home screen even if walk-through fails (we don't need it for demo)
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           Navigator.pushReplacementNamed(context, navBar, arguments: 0);
  //         });
  //       }
  //       return buildUI(context);
  //     },
  //   );
  // }

@override
Widget build(BuildContext context) {
  return BlocConsumer<SplashScreenBloc, SplashScreenState>(
    listener: (context, state) {
      // SUCCESS: We got splash data → go to home screen immediately
      if (state is SplashScreenSuccess) {
        splashScreenModel = state.splashScreenModel;
        setApplicationData(context);

        // Small delay so user sees splash for a second (looks professional)
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, navBar, arguments: 0);
          }
        });
      }

      // ERROR on walk-through → ignore and go to home anyway
      if (state is WalkThroughError) {
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, navBar, arguments: 0);
          }
        });
      }

      // Any other error → still go to home (we don’t care for demo
      if (state is SplashScreenError) {
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, navBar, arguments: 0);
          }
        });
      }
    },
    builder: (context, state) {
      // Show loader only at the very beginning
      bool showLoader = state is SplashScreenInitial;

      return Stack(
        children: [
          Container(
            width: AppSizes.width.toDouble(),
            height: AppSizes.height.toDouble(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/splash_background.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: AppSizes.width / 2.3,
                width: AppSizes.width,
                image: const AssetImage("lib/assets/images/splash_logo.png"),
              ),
              const SizedBox(height: AppSizes.extraPadding),
              Image(
                height: AppSizes.width / 3.2,
                width: AppSizes.width,
                image: const AssetImage("lib/assets/images/splash_top.png"),
              ),
              const SizedBox(height: AppSizes.extraPadding),
              Image(
                height: AppSizes.normalPadding,
                width: AppSizes.width,
                image: const AssetImage("lib/assets/images/sperator.png"),
              ),
              const SizedBox(height: AppSizes.extraPadding),
              Image(
                height: AppSizes.width / 6,
                width: AppSizes.width,
                image: const AssetImage("lib/assets/images/splash_bottom.png"),
              ),
            ],
          ),
          Positioned(
            bottom: AppSizes.height * 0.1,
            left: 0,
            right: 0,
            child: Visibility(
              visible: showLoader,
              child: Loader(color: AppColors.white),
            ),
          ),
        ],
      );
    },
  );
}

  Widget buildUI(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppSizes.width.toDouble(),
          height: AppSizes.height.toDouble(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/splash_background.png"),
              fit: BoxFit.fill,
            ), // replace with client splash screen
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: AppSizes.width / 2.3,
              width: AppSizes.width,
              image: const AssetImage("lib/assets/images/splash_logo.png"),
            ),
            const SizedBox(height: AppSizes.extraPadding),
            Image(
              height: AppSizes.width / 3.2,
              width: AppSizes.width,
              image: const AssetImage("lib/assets/images/splash_top.png"),
            ),
            const SizedBox(height: AppSizes.extraPadding),
            Image(
              height: AppSizes.normalPadding,
              width: AppSizes.width,
              image: const AssetImage("lib/assets/images/sperator.png"),
            ),
            const SizedBox(height: AppSizes.extraPadding),
            Image(
              height: AppSizes.width / 6,
              width: AppSizes.width,
              image: const AssetImage("lib/assets/images/splash_bottom.png"),
            ),
          ],
        ),

        //=========remove below Positioned Widget for client app =======//
        //
        // Positioned(
        //     top: AppSizes.height * 0.1,
        //     right: 0,
        //     left: 0,
        //     child: SizedBox(
        //         height: AppSizes.width / 3.6,
        //         child: const Image(
        //           image: AssetImage("lib/assets/images/splash_top.png"),
        //         ))),
        // Positioned(
        //     top: AppSizes.height * 0.35,
        //     right: 0,
        //     left: 0,
        //     child: SizedBox(
        //         height: AppSizes.width / 3,
        //         child: const Image(
        //           image: AssetImage("lib/assets/images/splash_logo.png"),
        //         ))),
        // Positioned(
        //     bottom: AppSizes.height * 0.04,
        //     right: 0,
        //     left: 0,
        //     child: SizedBox(
        //         height: AppSizes.width / 10,
        //         child: const Image(
        //           image: AssetImage("lib/assets/images/splash_bottom.png"),
        //         ))),

        //=============================================================//
        Positioned(
          bottom: AppSizes.height * 0.1,
          left: 0,
          right: 0,
          child: Visibility(
            visible: isLoading,
            child: Loader(color: AppColors.white),
          ),
        ),
      ],
    );
  }

  // void setApplicationData(BuildContext context) {
  //   AppSharedPref().setSplashData(splashScreenModel);
  //   AppSharedPref().setWishlistData(splashScreenModel!.wishlist);
  //   AppSharedPref().setGuestCheckout(
  //     splashScreenModel?.allowGuestCheckout ?? false,
  //   );
  //   AppSharedPref().setGuestCartCount(splashScreenModel?.cartCount ?? 0);

  //   AppSharedPref().setIsWatchLoginAvailable(
  //     splashScreenModel?.addons?.odooWatchApp ?? false,
  //   );
  //   if (AppSharedPref().getWalkThroughVersion().isEmpty ?? false) {
  //     AppSharedPref().setWalkThroughVersion(
  //       splashScreenModel?.walkThroughVersion ?? "",
  //     );
  //   }
  //   setOnBoardingVersion();
  //   if (AppSharedPref().getAppLanguage() == null) {
  //     WidgetsBinding.instance?.addPostFrameCallback((_) {
  //       if (AppSharedPref().getAppLanguage() == null &&
  //           (splashScreenModel?.defaultLanguage?.length ?? 0) > 0) {
  //         AppSharedPref().setAppLanguage(
  //           splashScreenModel?.defaultLanguage?[0] ?? "en",
  //         );
  //       }
  //       if (MyApp.themeNotifier.value == ThemeMode.dark) {
  //         MyApp.themeNotifier.value = ThemeMode.light;
  //       } else {
  //         AppSharedPref().setAppLanguage(
  //           splashScreenModel?.defaultLanguage?[0] ?? "en",
  //         );
  //         AppSharedPref().setFirstLang(true);
  //         MyApp.themeNotifier.value = ThemeMode.dark;
  //       }
  //     });
  //   } else {
  //     if (AppSharedPref().getAppLanguage() == null &&
  //         (splashScreenModel?.defaultLanguage?.length ?? 0) > 0) {
  //       AppSharedPref().setAppLanguage(
  //         splashScreenModel?.defaultLanguage?[0] ?? "en",
  //       );
  //     }
  //   }

  //   if (AppSharedPref().getAppCurrency() == null ||
  //       splashScreenModel!.allPricelists == null ||
  //       splashScreenModel!.allPricelists!.isEmpty) {
  //     debugPrint("setApplicationData  setAppCurrency");
  //     AppSharedPref().setAppCurrency(splashScreenModel!.defaultPricelist![0]);
  //   }

  //   checkForDeepLink(context).then((value) => print("deep linking-->$value"));
  // }

  void setApplicationData(BuildContext context) {
    AppSharedPref().setSplashData(splashScreenModel);
    AppSharedPref().setWishlistData(splashScreenModel?.wishlist ?? []);
    AppSharedPref().setGuestCheckout(
      splashScreenModel?.allowGuestCheckout ?? false,
    );
    AppSharedPref().setGuestCartCount(splashScreenModel?.cartCount ?? 0);
    AppSharedPref().setIsWatchLoginAvailable(
      splashScreenModel?.addons?.odooWatchApp ?? false,
    );

    // Walkthrough version
    if (AppSharedPref().getWalkThroughVersion().isEmpty) {
      AppSharedPref().setWalkThroughVersion(
        splashScreenModel?.walkThroughVersion ?? "",
      );
    }

    // Language – safe
    if (AppSharedPref().getAppLanguage() == null) {
      String defaultLang = "en";
      if (splashScreenModel?.defaultLanguage != null &&
          splashScreenModel!.defaultLanguage!.isNotEmpty) {
        defaultLang = splashScreenModel!.defaultLanguage![0];
      }
      AppSharedPref().setAppLanguage(defaultLang);
    }

    // CURRENCY – THIS WAS CRASHING BEFORE
    if (AppSharedPref().getAppCurrency() == null ||
        splashScreenModel?.allPricelists == null ||
        splashScreenModel!.allPricelists!.isEmpty) {
      String currency = splashScreenModel?.defaultPricelist?.isNotEmpty == true
          ? splashScreenModel!.defaultPricelist![0]
          : "\$"; // fallback dollar sign
      AppSharedPref().setAppCurrency(currency);
      debugPrint("setApplicationData → Currency set to: $currency");
    }

    // These two lines are removed because appName & dominantColor do NOT exist in your model
    // AppSharedPref().setAppName(...);
    // AppSharedPref().setDominantColor(...);

    setOnBoardingVersion();
    checkForDeepLink(context);
  }

  void setOnBoardingVersion() {
    if (splashScreenModel?.walkThroughVersion?.isNotEmpty ?? false) {
      if ((double.tryParse(
                AppSharedPref().getWalkThroughVersion().toString() ?? "",
              ) ??
              0.0) <
          (double.tryParse("${splashScreenModel?.walkThroughVersion}") ??
              0.0)) {
        AppSharedPref().setShowWalkThrough(true);
      }
    }
  }

  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future<String> checkForDeepLink(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        var data = await methodChannel.invokeMethod('initialLink');
        if (data.toString().contains("product")) {
          var splitData = data.toString().split("-");
          Navigator.of(context).pushReplacementNamed(
            productPage,
            arguments: getProductDataMap('', splitData.last),
          );
        }
        return data;
      } else if (Platform.isIOS) {
        var data = await methodChannel.invokeMethod('uni_links/events');
        if (data.toString().contains("product")) {
          var splitData = data.toString().split("-");
          Navigator.of(context).pushReplacementNamed(
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
}
