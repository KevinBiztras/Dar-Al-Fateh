// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WishlistModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistModelAdapter extends TypeAdapter<WishlistModel> {
  @override
  final int typeId = 38;

  @override
  WishlistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistModel(
      itemsPerPage: fields[0] as int?,
      addons: fields[1] as Addons?,
      customerId: fields[2] as int?,
      userId: fields[3] as int?,
      cartCount: fields[4] as int?,
      wishlistCount: fields[5] as int?,
      isEmailVerified: fields[6] as bool?,
      wishLists: (fields[7] as List?)?.cast<WishListItems>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, WishlistModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.customerId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.cartCount)
      ..writeByte(5)
      ..write(obj.wishlistCount)
      ..writeByte(6)
      ..write(obj.isEmailVerified)
      ..writeByte(7)
      ..write(obj.wishLists)
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
      other is WishlistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WishListItemsAdapter extends TypeAdapter<WishListItems> {
  @override
  final int typeId = 39;

  @override
  WishListItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishListItems(
      id: fields[0] as int?,
      name: fields[1] as String?,
      thumbNail: fields[2] as String?,
      priceReduce: fields[3] as String?,
      priceUnit: fields[4] as String?,
      productId: fields[5] as int?,
      templateId: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WishListItems obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumbNail)
      ..writeByte(3)
      ..write(obj.priceReduce)
      ..writeByte(4)
      ..write(obj.priceUnit)
      ..writeByte(5)
      ..write(obj.productId)
      ..writeByte(6)
      ..write(obj.templateId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishListItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) =>
    WishlistModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['isEmailVerified'] as bool?,
      wishLists: (json['wishLists'] as List<dynamic>?)
          ?.map((e) => WishListItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'isEmailVerified': instance.isEmailVerified,
      'wishLists': instance.wishLists,
    };

WishListItems _$WishListItemsFromJson(Map<String, dynamic> json) =>
    WishListItems(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      priceReduce: json['priceReduce'] as String?,
      priceUnit: json['priceUnit'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
      templateId: (json['templateId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WishListItemsToJson(WishListItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbNail': instance.thumbNail,
      'priceReduce': instance.priceReduce,
      'priceUnit': instance.priceUnit,
      'productId': instance.productId,
      'templateId': instance.templateId,
    };
