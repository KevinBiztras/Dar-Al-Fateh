// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 42;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      customerId: fields[2] as int?,
      userId: fields[3] as int?,
      addons: fields[1] as Addons?,
      cartCount: fields[4] as int?,
      isEmailVerified: fields[6] as bool?,
      isSeller: fields[7] as bool?,
      itemsPerPage: fields[0] as int?,
      recentOrders: (fields[11] as List?)?.cast<RecentOrders>(),
      sellerGroup: fields[8] as String?,
      sellerState: fields[9] as String?,
      tcount: fields[10] as int?,
      wishlistCount: fields[5] as int?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.isSeller)
      ..writeByte(8)
      ..write(obj.sellerGroup)
      ..writeByte(9)
      ..write(obj.sellerState)
      ..writeByte(10)
      ..write(obj.tcount)
      ..writeByte(11)
      ..write(obj.recentOrders)
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
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentOrdersAdapter extends TypeAdapter<RecentOrders> {
  @override
  final int typeId = 43;

  @override
  RecentOrders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentOrders(
      url: fields[8] as String?,
      name: fields[4] as String?,
      needCartMerge: fields[9] as bool?,
      id: fields[3] as int?,
      amountTotal: fields[0] as String?,
      canReOrder: fields[1] as bool?,
      createDate: fields[2] as String?,
      shippingAddress: fields[6] as String?,
      shippingAddressUrl: fields[5] as String?,
      status: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentOrders obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.amountTotal)
      ..writeByte(1)
      ..write(obj.canReOrder)
      ..writeByte(2)
      ..write(obj.createDate)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.shippingAddressUrl)
      ..writeByte(6)
      ..write(obj.shippingAddress)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.url)
      ..writeByte(9)
      ..write(obj.needCartMerge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentOrdersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      recentOrders: (json['recentOrders'] as List<dynamic>?)
          ?.map((e) => RecentOrders.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_state'] as String?,
      tcount: (json['tcount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
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
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'tcount': instance.tcount,
      'recentOrders': instance.recentOrders,
    };

RecentOrders _$RecentOrdersFromJson(Map<String, dynamic> json) => RecentOrders(
      url: json['url'] as String?,
      name: json['name'] as String?,
      needCartMerge: json['needCartMerge'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      amountTotal: json['amount_total'] as String?,
      canReOrder: json['canReOrder'] as bool?,
      createDate: json['create_date'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      shippingAddressUrl: json['shipAdd_url'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$RecentOrdersToJson(RecentOrders instance) =>
    <String, dynamic>{
      'amount_total': instance.amountTotal,
      'canReOrder': instance.canReOrder,
      'create_date': instance.createDate,
      'id': instance.id,
      'name': instance.name,
      'shipAdd_url': instance.shippingAddressUrl,
      'shipping_address': instance.shippingAddress,
      'status': instance.status,
      'url': instance.url,
      'needCartMerge': instance.needCartMerge,
    };
