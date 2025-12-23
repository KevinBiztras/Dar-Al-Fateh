// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountInfoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountInfoModelAdapter extends TypeAdapter<AccountInfoModel> {
  @override
  final int typeId = 44;

  @override
  AccountInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountInfoModel(
      wishlistCount: fields[4] as int?,
      sellerState: fields[8] as String?,
      downloadRequest: fields[9] as bool?,
      sellerGroup: fields[7] as String?,
      isSeller: fields[6] as bool?,
      isEmailVerified: fields[5] as bool?,
      cartCount: fields[3] as int?,
      addons: fields[1] as Addons?,
      userId: fields[2] as int?,
      itemsPerPage: fields[0] as int?,
      downloadMessage: fields[10] as String?,
      downloadUrl: fields[11] as String?,
      customerBannerImage: fields[12] as String?,
      customerProfileImage: fields[13] as String?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, AccountInfoModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.cartCount)
      ..writeByte(4)
      ..write(obj.wishlistCount)
      ..writeByte(5)
      ..write(obj.isEmailVerified)
      ..writeByte(6)
      ..write(obj.isSeller)
      ..writeByte(7)
      ..write(obj.sellerGroup)
      ..writeByte(8)
      ..write(obj.sellerState)
      ..writeByte(9)
      ..write(obj.downloadRequest)
      ..writeByte(10)
      ..write(obj.downloadMessage)
      ..writeByte(11)
      ..write(obj.downloadUrl)
      ..writeByte(12)
      ..write(obj.customerBannerImage)
      ..writeByte(13)
      ..write(obj.customerProfileImage)
      ..writeByte(100)
      ..write(obj.success)
      ..writeByte(101)
      ..write(obj.responseCode)
      ..writeByte(102)
      ..write(obj.message)
      ..writeByte(103)
      ..write(obj.accessDenied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoModel _$AccountInfoModelFromJson(Map<String, dynamic> json) =>
    AccountInfoModel(
      wishlistCount: (json['WishlistCount'] as num?)?.toInt(),
      sellerState: json['seller_state'] as String?,
      downloadRequest: json['downloadRequest'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      isSeller: json['is_seller'] as bool?,
      isEmailVerified: json['is_email_verified'] as bool?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      userId: (json['userId'] as num?)?.toInt(),
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      downloadMessage: json['downloadMessage'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      customerBannerImage: json['customerBannerImage'] as String?,
      customerProfileImage: json['customerProfileImage'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$AccountInfoModelToJson(AccountInfoModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'downloadRequest': instance.downloadRequest,
      'downloadMessage': instance.downloadMessage,
      'downloadUrl': instance.downloadUrl,
      'customerBannerImage': instance.customerBannerImage,
      'customerProfileImage': instance.customerProfileImage,
    };
