/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HomeScreenModel.dart';

part 'SplashScreenModel.g.dart';

@HiveType(typeId: HiveTypeConstants.splashPageModelHiveTypeId)
@JsonSerializable()
class SplashScreenModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
  @HiveField(2)
  @JsonKey(name: "allow_resetPwd")
  bool? allowResetPwd;
  @HiveField(3)
  @JsonKey(name: "allow_signup")
  bool? allowSignup;
  @HiveField(4)
  @JsonKey(name: "allow_guestCheckout")
  bool? allowGuestCheckout;
  @HiveField(5)
  @JsonKey(name: "allow_gmailSign")
  bool? allowGmailSign;
  @HiveField(6)
  @JsonKey(name: "allow_facebookSign")
  bool? allowFacebookSign;
  @HiveField(7)
  @JsonKey(name: "allow_twitterSign")
  bool? allowTwitterSign;
  @HiveField(8)
  bool? allowShipping;
  @HiveField(9)
  @JsonKey(name: "privacy_policy_url")
  dynamic privacyPolicyUrl;
  @HiveField(10)
  List<SortData>? sortData;
  @HiveField(11)
  List<String>? defaultLanguage;
  @HiveField(12)
  List<List<String>>? allLanguages;
  @HiveField(13)
  @JsonKey(name: "TermsAndConditions")
  @JsonKey(name: "termsAndConditions")
  bool? termsAndConditions;
  @HiveField(14)
  List<List<String>>? ratingStatus;
  @HiveField(15)
  @JsonKey(name: "WishlistCount")
  int? WishlistCount;
  @HiveField(16)
  @JsonKey(name: "wishlist")
  List<int>? wishlist;
  @HiveField(17)
  List<String>? defaultPricelist;
  @HiveField(18)
  List<List<String>>? allPricelists;
  @HiveField(19)
  @JsonKey(name: "allow_walkThrough")
  bool? allowWalkThrough;
  @HiveField(20)
  @JsonKey(name: "walkThrough_version")
  String? walkThroughVersion;
  @HiveField(21)
  @JsonKey(name: "featured_category_view_type")
  String? featuredCategoryViewType;
  @HiveField(22)
  @JsonKey(name: "couponsProgram")
  bool? couponsProgram;
  @HiveField(23)
  @JsonKey(name: "isCrossSelling")
  bool? isCrossSelling;
  @HiveField(24)
  @JsonKey(name: "isUpSelling")
  bool? isUpSelling;
  @HiveField(25)
  @JsonKey(name: "redirectToLogin")
  bool? redirectToLogin;
  @HiveField(26)
  @JsonKey(name: "allowLiveChat")
  bool? allowLiveChat;
  @HiveField(27)
  @JsonKey(name: "android_version")
  String? androidVersion;
  @HiveField(28)
  @JsonKey(name: "ios_version")
  String? iOSVersion;

  SplashScreenModel(
      {this.itemsPerPage,
      this.walkThroughVersion,
      this.allowWalkThrough,
      this.addons,
      this.featuredCategoryViewType,
      this.allowResetPwd,
      this.allowSignup,
      this.allowGuestCheckout,
      this.allowGmailSign,
      this.allowFacebookSign,
      this.allowTwitterSign,
      this.allowShipping,
      this.privacyPolicyUrl,
      this.allLanguages,
      this.defaultLanguage,
      this.termsAndConditions,
      this.ratingStatus,
      this.sortData,
      this.WishlistCount,
      this.wishlist,
      this.defaultPricelist,
      this.couponsProgram,
      this.isUpSelling,
      this.isCrossSelling,
      this.redirectToLogin,
      this.allowLiveChat,
      this.androidVersion,
      this.iOSVersion,
      this.allPricelists});

  factory SplashScreenModel.fromJson(Map<String, dynamic> json) =>
      _$SplashScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SplashScreenModelToJson(this);
}
@HiveType(typeId: HiveTypeConstants.sortDataTypeId)
@JsonSerializable()
class SortData {
  @HiveField(0)
  String ? code;
  @HiveField(1)
  String ? label;

  SortData({
    this.code,
    this.label,
  });


  factory SortData.fromJson(Map<String, dynamic> json) =>
      _$SortDataFromJson(json);

  Map<String, dynamic> toJson() => _$SortDataToJson(this);
}
