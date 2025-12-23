// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartViewModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartViewModelAdapter extends TypeAdapter<CartViewModel> {
  @override
  final int typeId = 18;

  @override
  CartViewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartViewModel(
      itemsPerPage: fields[0] as int?,
      addons: fields[1] as Addons?,
      customerId: fields[2] as int?,
      userId: fields[3] as int?,
      cartCount: fields[4] as int?,
      wishlistCount: fields[5] as int?,
      isEmailVerified: fields[6] as bool?,
      name: fields[7] as String?,
      subtotal: fields[8] as Subtotal?,
      tax: fields[9] as Subtotal?,
      grandtotal: fields[10] as Subtotal?,
      items: (fields[11] as List?)?.cast<Items>(),
      accessoriesProducts: (fields[12] as List?)?.cast<Accessories>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, CartViewModel obj) {
    writer
      ..writeByte(17)
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
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.subtotal)
      ..writeByte(9)
      ..write(obj.tax)
      ..writeByte(10)
      ..write(obj.grandtotal)
      ..writeByte(11)
      ..write(obj.items)
      ..writeByte(12)
      ..write(obj.accessoriesProducts)
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
      other is CartViewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccessoriesAdapter extends TypeAdapter<Accessories> {
  @override
  final int typeId = 62;

  @override
  Accessories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Accessories(
      fields[0] as int?,
      fields[1] as int?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Accessories obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.templateId)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.priceUnit)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubtotalAdapter extends TypeAdapter<Subtotal> {
  @override
  final int typeId = 19;

  @override
  Subtotal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subtotal(
      title: fields[0] as String?,
      value: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Subtotal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtotalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemsAdapter extends TypeAdapter<Items> {
  @override
  final int typeId = 20;

  @override
  Items read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Items(
      lineId: fields[0] as int?,
      templateId: fields[1] as int?,
      name: fields[2] as String?,
      thumbNail: fields[3] as String?,
      priceReduce: fields[4] as String?,
      priceUnit: fields[5] as String?,
      qty: fields[6] as double?,
      total: fields[7] as String?,
      isEditable: fields[9] as bool?,
      discount: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Items obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.lineId)
      ..writeByte(1)
      ..write(obj.templateId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.thumbNail)
      ..writeByte(4)
      ..write(obj.priceReduce)
      ..writeByte(5)
      ..write(obj.priceUnit)
      ..writeByte(6)
      ..write(obj.qty)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.discount)
      ..writeByte(9)
      ..write(obj.isEditable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartViewModel _$CartViewModelFromJson(Map<String, dynamic> json) =>
    CartViewModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      name: json['name'] as String?,
      subtotal: json['subtotal'] == null
          ? null
          : Subtotal.fromJson(json['subtotal'] as Map<String, dynamic>),
      tax: json['tax'] == null
          ? null
          : Subtotal.fromJson(json['tax'] as Map<String, dynamic>),
      grandtotal: json['grandtotal'] == null
          ? null
          : Subtotal.fromJson(json['grandtotal'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      accessoriesProducts: (json['accessoriesProducts'] as List<dynamic>?)
          ?.map((e) => Accessories.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$CartViewModelToJson(CartViewModel instance) =>
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
      'is_email_verified': instance.isEmailVerified,
      'name': instance.name,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'grandtotal': instance.grandtotal,
      'items': instance.items,
      'accessoriesProducts': instance.accessoriesProducts,
    };

Accessories _$AccessoriesFromJson(Map<String, dynamic> json) => Accessories(
      (json['templateId'] as num?)?.toInt(),
      (json['productId'] as num?)?.toInt(),
      json['name'] as String?,
      json['priceUnit'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$AccessoriesToJson(Accessories instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'productId': instance.productId,
      'name': instance.name,
      'priceUnit': instance.priceUnit,
      'image': instance.image,
    };

Subtotal _$SubtotalFromJson(Map<String, dynamic> json) => Subtotal(
      title: json['title'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$SubtotalToJson(Subtotal instance) => <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      lineId: (json['lineId'] as num?)?.toInt(),
      templateId: (json['templateId'] as num?)?.toInt(),
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      priceReduce: json['priceReduce'] as String?,
      priceUnit: json['priceUnit'] as String?,
      qty: (json['qty'] as num?)?.toDouble(),
      total: json['total'] as String?,
      isEditable: json['isEditable'] as bool?,
      discount: json['discount'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'lineId': instance.lineId,
      'templateId': instance.templateId,
      'name': instance.name,
      'thumbNail': instance.thumbNail,
      'priceReduce': instance.priceReduce,
      'priceUnit': instance.priceUnit,
      'qty': instance.qty,
      'total': instance.total,
      'discount': instance.discount,
      'isEditable': instance.isEditable,
    };
