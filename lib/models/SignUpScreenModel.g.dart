// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpScreenModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpScreenModel _$SignUpScreenModelFromJson(Map<String, dynamic> json) =>
    SignUpScreenModel(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      login: json['login'] == null
          ? null
          : Login.fromJson(json['login'] as Map<String, dynamic>),
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      credentials: json['cred'] == null
          ? null
          : Cred.fromJson(json['cred'] as Map<String, dynamic>),
      sellerMessage: json['seller_message'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$SignUpScreenModelToJson(SignUpScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'userId': instance.userId,
      'customerId': instance.customerId,
      'seller_message': instance.sellerMessage,
      'login': instance.login,
      'cred': instance.credentials,
    };

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      userId: (json['userId'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      success: json['success'] as bool?,
      message: json['message'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      cartId: json['cartId'] as String?,
      customerBannerImage: json['customerBannerImage'] as String?,
      customerLang: json['customerLang'] as String?,
      customerProfileImage: json['customerProfileImage'] as String?,
      isEmailVerified: json['is_email_verified'] as bool?,
      responseCode: (json['responseCode'] as num?)?.toInt(),
      themeCode: json['themeCode'] as String?,
      wishListCount: (json['WishlistCount'] as num?)?.toInt(),
      isSeller: json['is_seller'] as bool?,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishListCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'customerBannerImage': instance.customerBannerImage,
      'customerProfileImage': instance.customerProfileImage,
      'cartId': instance.cartId,
      'themeCode': instance.themeCode,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerLang': instance.customerLang,
    };

Cred _$CredFromJson(Map<String, dynamic> json) => Cred(
      login: json['login'] as String?,
      password: json['pwd'] as String?,
    );

Map<String, dynamic> _$CredToJson(Cred instance) => <String, dynamic>{
      'login': instance.login,
      'pwd': instance.password,
    };
