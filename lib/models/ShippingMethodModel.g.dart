// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShippingMethodModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShippingMethodModelAdapter extends TypeAdapter<ShippingMethodModel> {
  @override
  final int typeId = 26;

  @override
  ShippingMethodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShippingMethodModel(
      itemsPerPage: fields[0] as int?,
      customerId: fields[1] as int?,
      userId: fields[2] as int?,
      cartCount: fields[3] as int?,
      wishlistCount: fields[4] as int?,
      isEmailVerified: fields[5] as bool?,
      shippingMethods: (fields[6] as List?)?.cast<ShippingMethods>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, ShippingMethodModel obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.shippingMethods)
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
      other is ShippingMethodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ShippingMethodsAdapter extends TypeAdapter<ShippingMethods> {
  @override
  final int typeId = 27;

  @override
  ShippingMethods read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShippingMethods(
      name: fields[0] as String?,
      id: fields[1] as int?,
      description: fields[2] as String?,
      price: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShippingMethods obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingMethodsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingMethodModel _$ShippingMethodModelFromJson(Map<String, dynamic> json) =>
    ShippingMethodModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['WishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      shippingMethods: (json['ShippingMethods'] as List<dynamic>?)
          ?.map((e) => ShippingMethods.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$ShippingMethodModelToJson(
        ShippingMethodModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'itemsPerPage': instance.itemsPerPage,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'ShippingMethods': instance.shippingMethods,
    };

ShippingMethods _$ShippingMethodsFromJson(Map<String, dynamic> json) =>
    ShippingMethods(
      name: json['name'] as String?,
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$ShippingMethodsToJson(ShippingMethods instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'price': instance.price,
    };
