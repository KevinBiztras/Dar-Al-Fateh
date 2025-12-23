// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressDetailModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressDetailModelAdapter extends TypeAdapter<AddressDetailModel> {
  @override
  final int typeId = 30;

  @override
  AddressDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressDetailModel(
      itemsPerPage: fields[0] as int?,
      customerId: fields[1] as int?,
      userId: fields[2] as int?,
      cartCount: fields[3] as int?,
      wishlistCount: fields[4] as int?,
      isEmailVerified: fields[5] as bool?,
      isSeller: fields[6] as bool?,
      name: fields[7] as String?,
      street: fields[8] as String?,
      zip: fields[9] as String?,
      city: fields[10] as String?,
      stateId: fields[11] as dynamic,
      countryId: fields[12] as dynamic,
      phone: fields[13] as String?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, AddressDetailModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.customerId)
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
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.street)
      ..writeByte(9)
      ..write(obj.zip)
      ..writeByte(10)
      ..write(obj.city)
      ..writeByte(11)
      ..write(obj.stateId)
      ..writeByte(12)
      ..write(obj.countryId)
      ..writeByte(13)
      ..write(obj.phone)
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
      other is AddressDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDetailModel _$AddressDetailModelFromJson(Map<String, dynamic> json) =>
    AddressDetailModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      name: json['name'] as String?,
      street: json['street'] as String?,
      zip: json['zip'] as String?,
      city: json['city'] as String?,
      stateId: json['state_id'],
      countryId: json['country_id'],
      phone: json['phone'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$AddressDetailModelToJson(AddressDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'itemsPerPage': instance.itemsPerPage,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'name': instance.name,
      'street': instance.street,
      'zip': instance.zip,
      'city': instance.city,
      'state_id': instance.stateId,
      'country_id': instance.countryId,
      'phone': instance.phone,
    };
