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

class ApiConstant {
  // static const String baseUrl = 'https://assets-genuine-robin-carol.trycloudflare.com/';
  static const String baseUrl = 'https://example.com/';
  // static const String baseData = "authkey:423b-85d9-57399a7a226e";
  static const String baseData = "authkey:your_auth_key";

  static const bool isCacheFeatureEnabled = true;
  static const bool isPreFetchingFeatureEnabled = false;
}

class AppConstant {
  static const String appDocPath = "";
  static const List<Locale> supportedLanguages = [
    Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    Locale.fromSubtags(languageCode: 'ar', countryCode: '001'),
    Locale.fromSubtags(languageCode: 'es', countryCode: 'CO'),
    Locale.fromSubtags(languageCode: 'fr', countryCode: 'BE'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
  ];
  static const String productTypeNotification = "product";
  static const String categoryTypeNotification = "category";
  static const String customTypeNotification = "custom";
  static const String orderTypeNotification = "lastOrder";
  static const String googleKey = "Your_map_api_key";

  //=======App Keys Constants=======//e
  static const productDefault = "default";
  static const productFixed = "fixed";
  static const featuredCategorySquareType = "square";
  static const featuredCategoryRoundedSquareType = "rounded_square";
  static const demoEmail = "";
  static const demoPassword = "";
  static const deactivateTemporary = "temporary";
  static const deactivatePermanent = "permanent";
  static const bannerImage = 'banner';
  static const profileImage = "image";
  static const userBannerImage = "bannerImage";

  //========Product Variant Types======//
  static const radioType = "radio";
  static const colorType = "color";

  //======Method Channel Name=====//
  static const channelName = "com.oddo.flutter/channel";

  //=============Search Type Image/Text==========//
  static const imageSearch = "ImageSearch";
  static const textSearch = "TextSearch";
}

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const int titleFontSize = 34;
  static const double sidePadding = 15;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 25;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const double genericPadding = 16.0;
  static const double iconButtonBorderRadius = 24;
  static const double itemHeight = 45;
  static double height = MediaQueryData.fromWindow(
    WidgetsBinding.instance!.window,
  ).size.height;
  static double width = MediaQueryData.fromWindow(
    WidgetsBinding.instance!.window,
  ).size.width;
  static const EdgeInsets bottomSheetPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 10,
  );
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const double normalPadding = 8.0;
  static const double mediumPadding = 12.0;
  static const double extraPadding = 16.0;
  static const double buttonHeight = 40;
}

class TextSizes {
  static const double mediumTextSize = 20;
  static const double textSize18 = 18;
  static const double textSizeNormal = 16;
}

class AppColors {
  static const red = Color(0xFFDB3022);
  static const lightRed = Color(0xFFF65F53);
  static const textBlue = Color(0xFF1A4391);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9E9E9E);
  static const gray = Color(0xCC757575);
  static const darkGray = Color(0xFF616161);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
  static const yellow = Color(0xFFEA9301);
  static const blue = Color(0xFF3D79EC);
  static const lightBlue = Color(0xCFD9D0F6);
}


