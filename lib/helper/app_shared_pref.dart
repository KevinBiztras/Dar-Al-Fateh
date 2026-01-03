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

import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:get_storage/get_storage.dart';

class AppSharedPref {
  //==========Shared Preference Keys===========//
  String loginKey = "loginKey";
  String isLogin = "false";
  String appLanguage = "appLanguage";
  String appCurrency = "appCurrency";
  String firstLang = "firstLang";
  String splashData = "splashData";
  String user = "user";
  String emailKey = "emailKey";
  String themeMode = "themeMode";
  String notification = "notification";
  String appVersion = "appVersion";
  String currentPassword = "currentPassword";


  // String isVisitingWithoutLogin = "isVisitingWithoutLogin";
  String userdata = "userdata";
  String socialLoginStatus = "socialLoginStatus";
  String walkThroughStatus = "walkThroughStatus";
  String guestCheckout = "guestCheckout";
  String defaultShipping = "defaultShipping";
  String walkThroughVersion = "walkThroughVersion";
  String watchStatus = "watchStatus";
  String wishlistData = "wishlistData";
  String compareData = "compareData";
  String hasDefaultShipping = "hasDefaultShipping";
  String recentSearchKey = "recent_searches";
  String websiteSaleComparison="websiteSaleComparison";

  //---------------Global Keys--------------//
  String fingerPrinfLoginData = "fingerprintLoginData";

  String firebaseToken = "firebaseToken";
  String deviceId = "deviceId";

  //=========================================//
  GetStorage userStorage =
      GetStorage("userRelatedData"); //---Use if info related to user only
  GetStorage globalStorage =
      GetStorage("globalStorage"); //-----Use if info not dependent on user

  //-------Used to initialized storage boxes for initial values
  Future<bool> init() async {
    await GetStorage.init("userRelatedData");
    await GetStorage.init("globalStorage");
    return true;
  }

  setLoginKey(String login_key) {
    userStorage.write(loginKey, login_key);
  }

  String? getLoginKey() {
    print(userStorage.read(loginKey));
    return userStorage.read(loginKey);
  }

  setIfLogin(bool? is_login) {
    userStorage.write(isLogin, is_login);
  }

  bool? getIfLogin() {
    return userStorage.read(isLogin);
  }

  setNotification(bool? isShow) {
    userStorage.write(notification, isShow);
  }

  bool? getNotification() {
    return userStorage.read(notification);
  }

  logoutUser() {
    userStorage.erase();
  }

  setSplashData(SplashScreenModel? splashModel) {
    userStorage.write(splashData, splashModel);
  }

  SplashScreenModel? getSplashData() {
    final data = userStorage.read(splashData);
    if (data != null && data is Map<String, dynamic>) {
      return SplashScreenModel.fromJson(data);
    }
    return data;
  }


  setWishlistData(List<int>? wishlist) {
    userStorage.write(wishlistData, wishlist);
  }

  List<int>? getWishlistData() {
    return userStorage.read(wishlistData);
  }
  void compareAvailability(bool? compare){
    userStorage.write(websiteSaleComparison, compare);
  }
  dynamic getCompareAvailability(){
    return userStorage.read(websiteSaleComparison);
  }

  setCompareData(List? compareId) {
    userStorage.write(compareData, compareId);
  }

  List? getCompareData() {
    return userStorage.read(compareData);
  }

  setUserData(UserDataModel? userDataModel) {
    userStorage.write(userdata, userDataModel?.toJson());
  }

  setIsSocialLogin(bool isSocialLogin) {
    userStorage.write(socialLoginStatus, isSocialLogin);
  }

  bool getIsSocialLogin() {
    return userStorage.read(socialLoginStatus) ?? false;
  }

  setShowWalkThrough(bool isShowWalkThrough) {
    globalStorage.write(walkThroughStatus, isShowWalkThrough);
  }

  bool showWalkThrough() {
    return globalStorage.read(walkThroughStatus) ?? true;
  }

  bool getGuestCheckout() {
    return userStorage.read(guestCheckout) ?? false;
  }

  setGuestCheckout(bool allowGuestCheckout) {
    userStorage.write(guestCheckout, allowGuestCheckout);
  }
  String getReleaseVersion() {
    return globalStorage.read(appVersion) ?? "";
  }

  setReleaseVersion(String releaseVersion) {
    globalStorage.write(appVersion, releaseVersion);
  }

  bool getHasDefaultShipping() {
    return userStorage.read(defaultShipping) ?? false;
  }

  setHasDefaultShipping(bool isHasDefaultShipping) {
    userStorage.write(defaultShipping, isHasDefaultShipping);
  }

  setWalkThroughVersion(String walkThroughVer) {
    globalStorage.write(walkThroughVersion, walkThroughVer);
  }

  String getWalkThroughVersion() {
    return globalStorage.read(walkThroughVersion) ?? "";
  }

  setFcmToken(String fcmToken) {
    globalStorage.write(firebaseToken, fcmToken);
  }

  String getFcmToken() {
    return globalStorage.read(firebaseToken) ?? "";
  }

  setIsWatchLoginAvailable(bool isAvailable) {
    globalStorage.write(watchStatus, isAvailable);
  }

  bool getIsWatchLoginAvailable() {
    return globalStorage.read(watchStatus) ?? false;
  }

  UserDataModel? getUserData() {
    var userMap = userStorage.read(userdata);
    if (userMap != null) {
      return UserDataModel.fromJson(userMap);
    }
    return null;
  }

//=============================================//
  setFingerPrintData(String savedKey) {
    globalStorage.write(fingerPrinfLoginData, savedKey);
  }

  String? getFingerPrintData() {
    return globalStorage.read(fingerPrinfLoginData);
  }

  setDeviceID(String id) {
    globalStorage.write(deviceId, id);
    print("deviceId---Write>>${globalStorage.read(deviceId)}");
  }

  String? getDeviceID() {
    print("deviceId--Read->>${globalStorage.read(deviceId)}");
    return globalStorage.read(deviceId);
  }

  setGuestCartCount(int count) {
    globalStorage.write("guestCartCount", count);
  }

  int? getGuestCartCount() {
    return globalStorage.read("guestCartCount");
  }

  void setGuestCartItems(List<Map<String, dynamic>> items) {
    globalStorage.write("guestCartItems", items);
  }

  List<Map<String, dynamic>> getGuestCartItems() {
    final raw = globalStorage.read("guestCartItems");
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return [];
  }

  void setGuestWishlistItems(List<Map<String, dynamic>> items) {
    globalStorage.write("guestWishlistItems", items);
  }

  List<Map<String, dynamic>> getGuestWishlistItems() {
    final raw = globalStorage.read("guestWishlistItems");
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return [];
  }

  setAppLanguage(String language) {
    globalStorage.write(appLanguage, language);
    print("AppLanguage---Write>>${globalStorage.read(appLanguage)}");
  }

  String? getAppLanguage() {
    print("AppLangauage--Read->>${globalStorage.read(appLanguage)}");
    return globalStorage.read(appLanguage);
  }

  setAppCurrency(String currency) {
    globalStorage.write(appCurrency, currency);
    print("AppCurrency---Write>>${globalStorage.read(appCurrency)}");
  }

  String? getAppCurrency() {
    print("AppCurrency--Read->>${globalStorage.read(appCurrency)}");
    return globalStorage.read(appCurrency);
  }

  setThemeMode(bool? isDarkTheme) {
    globalStorage.write(themeMode, isDarkTheme);
    print("WRITE MODE---$isDarkTheme");
  }

  bool? getThemeMode() {
    var value = globalStorage.read(themeMode);
    print("READ MODE---$value");
    return value;
  }

  setFirstLang(bool isFirst) {
    globalStorage.write(firstLang, isFirst);
  }

  bool getFirstLang() {
    return globalStorage.read(firstLang) ?? false;
  }

  setTimeZone(String timeZone) {
    globalStorage.write("timeZone", timeZone);
  }

  String? getTimeZone() {
    return globalStorage.read("timeZone");

  }
  setCurrentPassword(String password) {
    globalStorage.write(currentPassword, password);
    print("AppLanguage---Write>>${globalStorage.read(currentPassword)}");
  }

  String? getCurrentPassword() {
    print("AppLangauage--Read->>${globalStorage.read(currentPassword)}");

    return globalStorage.read(currentPassword);
  }

  /// Get the list of recent search items
  List<String> getRecentSearches() {
    return List<String>.from(globalStorage.read(recentSearchKey) ?? []);
  }

  /// Add a new product name to recent searches
  void addSearchItem(String productName) {
    List<String> currentList = getRecentSearches();

    // Remove if already exists to avoid duplicates
    currentList.remove(productName);

    // Insert at the beginning
    currentList.insert(0, productName);

    globalStorage.write(recentSearchKey, currentList);
  }

  /// Remove a product name from recent searches
  void removeSearchItem(String productName) {
    List<String> currentList = getRecentSearches();
    currentList.remove(productName);
    globalStorage.write(recentSearchKey, currentList);
  }

  /// Clear all recent searches
  void clearAllSearches() {
    globalStorage.remove(recentSearchKey);
  }


}
