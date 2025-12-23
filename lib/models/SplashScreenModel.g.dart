// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SplashScreenModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SplashScreenModelAdapter extends TypeAdapter<SplashScreenModel> {
  @override
  final int typeId = 0;

  @override
  SplashScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SplashScreenModel(
      itemsPerPage: fields[0] as int?,
      walkThroughVersion: fields[20] as String?,
      allowWalkThrough: fields[19] as bool?,
      addons: fields[1] as Addons?,
      featuredCategoryViewType: fields[21] as String?,
      allowResetPwd: fields[2] as bool?,
      allowSignup: fields[3] as bool?,
      allowGuestCheckout: fields[4] as bool?,
      allowGmailSign: fields[5] as bool?,
      allowFacebookSign: fields[6] as bool?,
      allowTwitterSign: fields[7] as bool?,
      allowShipping: fields[8] as bool?,
      privacyPolicyUrl: fields[9] as dynamic,
      allLanguages: (fields[12] as List?)
          ?.map((dynamic e) => (e as List).cast<String>())
          ?.toList(),
      defaultLanguage: (fields[11] as List?)?.cast<String>(),
      termsAndConditions: fields[13] as bool?,
      ratingStatus: (fields[14] as List?)
          ?.map((dynamic e) => (e as List).cast<String>())
          ?.toList(),
      sortData: (fields[10] as List?)?.cast<SortData>(),
      WishlistCount: fields[15] as int?,
      wishlist: (fields[16] as List?)?.cast<int>(),
      defaultPricelist: (fields[17] as List?)?.cast<String>(),
      couponsProgram: fields[22] as bool?,
      isUpSelling: fields[24] as bool?,
      isCrossSelling: fields[23] as bool?,
      redirectToLogin: fields[25] as bool?,
      allowLiveChat: fields[26] as bool?,
      androidVersion: fields[27] as String?,
      iOSVersion: fields[28] as String?,
      allPricelists: (fields[18] as List?)
          ?.map((dynamic e) => (e as List).cast<String>())
          ?.toList(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, SplashScreenModel obj) {
    writer
      ..writeByte(34)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.allowResetPwd)
      ..writeByte(3)
      ..write(obj.allowSignup)
      ..writeByte(4)
      ..write(obj.allowGuestCheckout)
      ..writeByte(5)
      ..write(obj.allowGmailSign)
      ..writeByte(6)
      ..write(obj.allowFacebookSign)
      ..writeByte(7)
      ..write(obj.allowTwitterSign)
      ..writeByte(8)
      ..write(obj.allowShipping)
      ..writeByte(9)
      ..write(obj.privacyPolicyUrl)
      ..writeByte(10)
      ..write(obj.sortData)
      ..writeByte(11)
      ..write(obj.defaultLanguage)
      ..writeByte(12)
      ..write(obj.allLanguages)
      ..writeByte(13)
      ..write(obj.termsAndConditions)
      ..writeByte(14)
      ..write(obj.ratingStatus)
      ..writeByte(15)
      ..write(obj.WishlistCount)
      ..writeByte(16)
      ..write(obj.wishlist)
      ..writeByte(17)
      ..write(obj.defaultPricelist)
      ..writeByte(18)
      ..write(obj.allPricelists)
      ..writeByte(19)
      ..write(obj.allowWalkThrough)
      ..writeByte(20)
      ..write(obj.walkThroughVersion)
      ..writeByte(21)
      ..write(obj.featuredCategoryViewType)
      ..writeByte(22)
      ..write(obj.couponsProgram)
      ..writeByte(23)
      ..write(obj.isCrossSelling)
      ..writeByte(24)
      ..write(obj.isUpSelling)
      ..writeByte(25)
      ..write(obj.redirectToLogin)
      ..writeByte(26)
      ..write(obj.allowLiveChat)
      ..writeByte(27)
      ..write(obj.androidVersion)
      ..writeByte(28)
      ..write(obj.iOSVersion)
      ..writeByte(100)
      ..write(obj.success)
      ..writeByte(101)
      ..write(obj.responseCode)
      ..writeByte(102)
      ..write(obj.message)
      ..writeByte(103)
      ..write(obj.accessDenied)
      ..writeByte(104)
      ..write(obj.cartCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SortDataAdapter extends TypeAdapter<SortData> {
  @override
  final int typeId = 61;

  @override
  SortData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SortData(
      code: fields[0] as String?,
      label: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SortData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashScreenModel _$SplashScreenModelFromJson(Map<String, dynamic> json) =>
    SplashScreenModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      walkThroughVersion: json['walkThrough_version'] as String?,
      allowWalkThrough: json['allow_walkThrough'] as bool?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      featuredCategoryViewType: json['featured_category_view_type'] as String?,
      allowResetPwd: json['allow_resetPwd'] as bool?,
      allowSignup: json['allow_signup'] as bool?,
      allowGuestCheckout: json['allow_guestCheckout'] as bool?,
      allowGmailSign: json['allow_gmailSign'] as bool?,
      allowFacebookSign: json['allow_facebookSign'] as bool?,
      allowTwitterSign: json['allow_twitterSign'] as bool?,
      allowShipping: json['allowShipping'] as bool?,
      privacyPolicyUrl: json['privacy_policy_url'],
      allLanguages: (json['allLanguages'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      defaultLanguage: (json['defaultLanguage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      termsAndConditions: json['TermsAndConditions'] as bool?,
      ratingStatus: (json['ratingStatus'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      sortData: (json['sortData'] as List<dynamic>?)
          ?.map((e) => SortData.fromJson(e as Map<String, dynamic>))
          .toList(),
      WishlistCount: (json['WishlistCount'] as num?)?.toInt(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      defaultPricelist: (json['defaultPricelist'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      couponsProgram: json['couponsProgram'] as bool?,
      isUpSelling: json['isUpSelling'] as bool?,
      isCrossSelling: json['isCrossSelling'] as bool?,
      redirectToLogin: json['redirectToLogin'] as bool?,
      allowLiveChat: json['allowLiveChat'] as bool?,
      androidVersion: json['android_version'] as String?,
      iOSVersion: json['ios_version'] as String?,
      allPricelists: (json['allPricelists'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$SplashScreenModelToJson(SplashScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'allow_resetPwd': instance.allowResetPwd,
      'allow_signup': instance.allowSignup,
      'allow_guestCheckout': instance.allowGuestCheckout,
      'allow_gmailSign': instance.allowGmailSign,
      'allow_facebookSign': instance.allowFacebookSign,
      'allow_twitterSign': instance.allowTwitterSign,
      'allowShipping': instance.allowShipping,
      'privacy_policy_url': instance.privacyPolicyUrl,
      'sortData': instance.sortData,
      'defaultLanguage': instance.defaultLanguage,
      'allLanguages': instance.allLanguages,
      'TermsAndConditions': instance.termsAndConditions,
      'ratingStatus': instance.ratingStatus,
      'WishlistCount': instance.WishlistCount,
      'wishlist': instance.wishlist,
      'defaultPricelist': instance.defaultPricelist,
      'allPricelists': instance.allPricelists,
      'allow_walkThrough': instance.allowWalkThrough,
      'walkThrough_version': instance.walkThroughVersion,
      'featured_category_view_type': instance.featuredCategoryViewType,
      'couponsProgram': instance.couponsProgram,
      'isCrossSelling': instance.isCrossSelling,
      'isUpSelling': instance.isUpSelling,
      'redirectToLogin': instance.redirectToLogin,
      'allowLiveChat': instance.allowLiveChat,
      'android_version': instance.androidVersion,
      'ios_version': instance.iOSVersion,
    };

SortData _$SortDataFromJson(Map<String, dynamic> json) => SortData(
      code: json['code'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$SortDataToJson(SortData instance) => <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
    };
