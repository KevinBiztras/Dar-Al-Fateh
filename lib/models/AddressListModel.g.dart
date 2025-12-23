// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressListModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressListModelAdapter extends TypeAdapter<AddressListModel> {
  @override
  final int typeId = 21;

  @override
  AddressListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressListModel(
      itemsPerPage: fields[0] as int?,
      customerId: fields[1] as int?,
      userId: fields[2] as int?,
      cartCount: fields[3] as int?,
      wishlistCount: fields[4] as int?,
      isEmailVerified: fields[5] as bool?,
      tcount: fields[6] as int?,
      addresses: (fields[7] as List?)?.cast<Addresses>(),
      defaultShippingAddressId: fields[8] as Addresses?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, AddressListModel obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.tcount)
      ..writeByte(7)
      ..write(obj.addresses)
      ..writeByte(8)
      ..write(obj.defaultShippingAddressId)
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
      other is AddressListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressesAdapter extends TypeAdapter<Addresses> {
  @override
  final int typeId = 22;

  @override
  Addresses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addresses(
      name: fields[0] as String?,
      url: fields[1] as String?,
      addressId: fields[2] as int?,
      displayName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Addresses obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.addressId)
      ..writeByte(3)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressListModel _$AddressListModelFromJson(Map<String, dynamic> json) =>
    AddressListModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      tcount: (json['tcount'] as num?)?.toInt(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Addresses.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultShippingAddressId: json['default_shipping_address_id'] == null
          ? null
          : Addresses.fromJson(
              json['default_shipping_address_id'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$AddressListModelToJson(AddressListModel instance) =>
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
      'tcount': instance.tcount,
      'addresses': instance.addresses,
      'default_shipping_address_id': instance.defaultShippingAddressId,
    };

Addresses _$AddressesFromJson(Map<String, dynamic> json) => Addresses(
      name: json['name'] as String?,
      url: json['url'] as String?,
      addressId: (json['addressId'] as num?)?.toInt(),
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$AddressesToJson(Addresses instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'addressId': instance.addressId,
      'display_name': instance.displayName,
    };
