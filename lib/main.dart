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
import 'dart:ui';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_navigation.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_structure/helper/app_restart.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/AddressDetailModel.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/ContactUsModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/FilterDataModel.dart';
import 'package:flutter_project_structure/models/GooglePlaceModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/models/NotificationModel.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/models/ReviewListModel.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/models/ShippingMethodModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/home/home_screen.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'constants/arguments_map.dart';
import 'constants/route_constant.dart';
import 'helper/push_notifications_manager.dart';
import 'local_database/hive_constants.dart';
import 'models/WishlistModel.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handling a background message ${message.messageId}');
// }

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// FirebaseDatabase secondaryDatabase = FirebaseDatabase.instance;

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await GetStorage().initStorage;
  await AppSharedPref().init();
  await FlutterDownloader.initialize(debug: true);
  // await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //     name: "deliveryBoy",
  //     options:  FirebaseOptions(
  //         apiKey: "",
  //         appId: appID,
  //         iosBundleId: "",
  //         messagingSenderId: "",
  //         projectId: "",
  //         databaseURL: ""));
  //
  // FirebaseApp app = Firebase.app("deliveryBoy");
  // secondaryDatabase = FirebaseDatabase.instanceFor(app: app);
  initializeHiveAdapters();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final currentTimeZone = await FlutterTimezone.getLocalTimezone();
  AppSharedPref().setTimeZone(currentTimeZone.identifier);
  runApp(AppRestart(child: const MyApp()));
}

Future<void> initializeHiveAdapters() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  bool isInstallOrUpdate = await isFirstTimeInstallOrUpdate();
  if (isInstallOrUpdate) {
    String hiveBoxName = HiveConstants.getHomePageModelBoxName();
    await Hive.deleteBoxFromDisk(hiveBoxName);
  }

  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BaseModelAdapter());
  Hive.registerAdapter(GetFilterAttributeAdapter());
  Hive.registerAdapter(FiltersAdapter());
  Hive.registerAdapter(AttributeValueAdapter());
  Hive.registerAdapter(AppliedFiltersAdapter());
  Hive.registerAdapter(AppliedFiltersValueAdapter());

  //Splash Screen Adapters
  Hive.registerAdapter(SplashScreenModelAdapter());
  Hive.registerAdapter(SortDataAdapter());

  // Home Screen Adapters
  Hive.registerAdapter(HomePageDataAdapter());
  Hive.registerAdapter(AddonsAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ChildrenAdapter());
  Hive.registerAdapter(ProductsAdapter());
  Hive.registerAdapter(RibbonAdapter());
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(HomepageDataListAdapter());
  Hive.registerAdapter(WishListItemsAdapter());
  // Product Screen Adapters
  Hive.registerAdapter(ProductScreenModelAdapter());
  Hive.registerAdapter(AttributeAdapter());
  Hive.registerAdapter(ValuesAdapter());
  Hive.registerAdapter(AlternativeProductsAdapter());
  Hive.registerAdapter(VariantsAdapter());
  Hive.registerAdapter(CombinationsAdapter());

  // Category Screen Adapters
  Hive.registerAdapter(CategoryScreenModelAdapter());

  // Review List Adapters
  Hive.registerAdapter(ReviewListModelAdapter());
  Hive.registerAdapter(ProductReviewsAdapter());

  //Cart Screen Adapters
  Hive.registerAdapter(CartViewModelAdapter());
  Hive.registerAdapter(SubtotalAdapter());
  Hive.registerAdapter(ItemsAdapter());

  //Address List Adapters
  Hive.registerAdapter(AddressListModelAdapter());
  Hive.registerAdapter(AddressesAdapter());

  //Country List Adapters
  Hive.registerAdapter(CountryListModelAdapter());
  Hive.registerAdapter(CountriesAdapter());
  Hive.registerAdapter(StatesAdapter());

  // Shiping Method Adapters
  Hive.registerAdapter(ShippingMethodModelAdapter());
  Hive.registerAdapter(ShippingMethodsAdapter());

  // Payment Model Adapters
  Hive.registerAdapter(PaymentModelAdapter());
  Hive.registerAdapter(AcquirersAdapter());

  //Address Detail Adapters
  Hive.registerAdapter(AddressDetailModelAdapter());

  //Order Review Adapters
  Hive.registerAdapter(OrderReviewModelAdapter());
  Hive.registerAdapter(PaymentTermsAdapter());
  Hive.registerAdapter(OrderReviewSubtotalAdapter());
  Hive.registerAdapter(OrderReviewItemsAdapter());
  Hive.registerAdapter(DeliveryAdapter());
  Hive.registerAdapter(PaymentDataAdapter());

  // Place Order Adapter
  Hive.registerAdapter(PlaceOrderModelAdapter());

  //Order Detail Adapters
  Hive.registerAdapter(OrderDetailModelAdapter());
  Hive.registerAdapter(OrderItemsAdapter());

  // Order Model Adapters
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(RecentOrdersAdapter());

  // AccountInfo Model Adapters
  Hive.registerAdapter(AccountInfoModelAdapter());

  //Notification Model Adapters
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(NotificationListAdapter());

  // Search Screen Model Adapters
  Hive.registerAdapter(SearchScreenModelAdapter());

  //Google Place Model Adapters
  Hive.registerAdapter(GooglePlaceModelAdapter());
  Hive.registerAdapter(ResultsAdapter());
  Hive.registerAdapter(GeometryAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(ViewPortAdapter());
  Hive.registerAdapter(PhotosAdapter());

  // SignUpTerms Model Adapters
  Hive.registerAdapter(SignUpTermsModelAdapter());

  // ContactUs Model Adapters
  Hive.registerAdapter(ContactUsModelAdapter());
  Hive.registerAdapter(ContactUsAddonsAdapter());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  void initState() {
    PushNotificationsManager().setUpFirebase(context);
    bool? isDarkMode = AppSharedPref().getThemeMode() ?? false;
    print('DarkMode--$isDarkMode');
    setState(() {
      if (isDarkMode == true) {
        MyApp.themeNotifier.value = ThemeMode.dark;
      } else {
        MyApp.themeNotifier.value = ThemeMode.light;
      }
    });
    // AnalyticsEventsFirebase().appOpenEvent();

    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   precacheAssetImages(context);
  //   return ValueListenableBuilder<ThemeMode>(
  //       valueListenable: MyApp.themeNotifier,
  //       builder: (BuildContext context, ThemeMode currentMode, __) {
  //         var string = AppSharedPref().getAppLanguage()?.split("_");

  //         var selectedLocale = Locale.fromSubtags(
  //             languageCode: string?[0] ?? "en",
  //             countryCode: string?[1] ?? "US");
  //         var isFirst = AppSharedPref().getFirstLang();
  //         if (isFirst) {
  //           AppSharedPref().setFirstLang(false);
  //           if (MyApp.themeNotifier.value == ThemeMode.dark) {
  //             MyApp.themeNotifier.value = ThemeMode.light;
  //             currentMode = ThemeMode.light;
  //           } else {
  //             MyApp.themeNotifier.value = ThemeMode.dark;
  //             currentMode = ThemeMode.dark;
  //           }
  //         }
  //         return MaterialApp(
  //             title: 'Odoo Mobile App',
  //             themeMode: currentMode,
  //             theme: AppTheme.lightTheme,
  //             darkTheme: AppTheme.darkTheme,
  //             onGenerateRoute: generateRouteSettings,
  //             initialRoute: splash,
  //             navigatorKey: navigatorKey,
  //             debugShowCheckedModeBanner: false,
  //             supportedLocales: AppConstant.supportedLanguages.map((e) => e),
  //             localizationsDelegates: const [
  //               AppLocalizations.delegate,
  //               GlobalMaterialLocalizations.delegate,
  //               GlobalWidgetsLocalizations.delegate,
  //               GlobalCupertinoLocalizations.delegate,
  //             ],
  //             locale: selectedLocale,
  //             localeResolutionCallback: (locale, supportedLocales) {
  //               var string = AppSharedPref().getAppLanguage()?.split("_");
  //               var selectedLocale = Locale.fromSubtags(
  //                   languageCode: string?[0] ?? "en",
  //                   countryCode: string?[1] ?? "US");
  //               if (AppConstant.supportedLanguages.contains(selectedLocale)) {
  //                 return selectedLocale;
  //               }
  //               return supportedLocales.first;
  //             });
  //       });
  // }
  @override
  Widget build(BuildContext context) {
    precacheAssetImages(context);

    // ──────── SAFE LANGUAGE FIX (this is the only thing that was crashing) ────────
    String languageCode = "en";
    String countryCode = "US";

    try {
      String? savedLang = AppSharedPref().getAppLanguage();
      if (savedLang != null && savedLang.isNotEmpty) {
        var parts = savedLang.split("_");
        languageCode = parts[0];
        if (parts.length > 1) countryCode = parts[1];
      }
    } catch (e) {
      languageCode = "en";
      countryCode = "US";
    }

    Locale selectedLocale = Locale(languageCode, countryCode);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Odoo Mobile Ap',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          navigatorKey: navigatorKey,
          initialRoute: splash,
          onGenerateRoute: generateRouteSettings,

          // Language settings – completely safe now
          locale: selectedLocale,
          supportedLocales: AppConstant.supportedLanguages,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          localeResolutionCallback: (deviceLocale, supportedLocales) {
            // Fallback to English if something goes wrong
            if (supportedLocales.contains(selectedLocale)) {
              return selectedLocale;
            }
            return const Locale('en', 'US');
          },
        );
      },
    );
  }
}

void precacheAssetImages(BuildContext context) async {
  await precacheImage(AssetImage("lib/assets/images/account.png"), context);
  await precacheImage(
    AssetImage("lib/assets/images/account_information.png"),
    context,
  );
  await precacheImage(
    AssetImage("lib/assets/images/address_book.png"),
    context,
  );
  await precacheImage(AssetImage("lib/assets/images/appIcon.png"), context);
  await precacheImage(
    AssetImage("lib/assets/images/bannerPlaceholder.png"),
    context,
  );
  await precacheImage(AssetImage("lib/assets/images/close.png"), context);
  await precacheImage(AssetImage("lib/assets/images/contact_us.png"), context);
  await precacheImage(AssetImage("lib/assets/images/currency.png"), context);
  await precacheImage(AssetImage("lib/assets/images/dashboard.png"), context);
  await precacheImage(AssetImage("lib/assets/images/ic_apple.png"), context);
  await precacheImage(
    AssetImage("lib/assets/images/ic_apple_dark.png"),
    context,
  );
  await precacheImage(AssetImage("lib/assets/images/ic_facebook.png"), context);
  await precacheImage(AssetImage("lib/assets/images/ic_google.png"), context);
  await precacheImage(AssetImage("lib/assets/images/login.png"), context);
  await precacheImage(AssetImage("lib/assets/images/logout.png"), context);
  await precacheImage(AssetImage("lib/assets/images/orders.png"), context);
  await precacheImage(AssetImage("lib/assets/images/placeholder.png"), context);
  await precacheImage(
    const AssetImage("lib/assets/images/placeholder.jpeg"),
    context,
  );
  await precacheImage(AssetImage("lib/assets/images/settings.png"), context);
  await precacheImage(AssetImage("lib/assets/images/sperator.png"), context);
  await precacheImage(AssetImage("lib/assets/images/splash.png"), context);
  await precacheImage(
    AssetImage("lib/assets/images/splash_background.png"),
    context,
  );
  await precacheImage(
    const AssetImage("lib/assets/images/splash_bottom.png"),
    context,
  );
  await precacheImage(AssetImage("lib/assets/images/splash_logo.png"), context);
  await precacheImage(AssetImage("lib/assets/images/splash_top.png"), context);
  await precacheImage(AssetImage("lib/assets/images/translation.png"), context);
  await precacheImage(AssetImage("lib/assets/images/wishlist.png"), context);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<bool> isFirstTimeInstallOrUpdate() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String? currentVersion = packageInfo.version;
  print("currentVersion----->$currentVersion");
  final previousVersion = AppSharedPref().getReleaseVersion();
  if (previousVersion.isEmpty || previousVersion != currentVersion) {
    await AppSharedPref().setReleaseVersion(currentVersion);
    print("currentVersion1----->$currentVersion");
    return true;
  }
  return false;
}
