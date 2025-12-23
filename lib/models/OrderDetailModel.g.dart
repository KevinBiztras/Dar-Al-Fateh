// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderDetailModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderDetailModelAdapter extends TypeAdapter<OrderDetailModel> {
  @override
  final int typeId = 40;

  @override
  OrderDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderDetailModel(
      canReOrder: fields[26] as bool?,
      id: fields[28] as int?,
      needCartMerge: fields[27] as bool?,
      itemsPerPage: fields[0] as int?,
      addons: fields[1] as Addons?,
      isOrderInvoiced: fields[24] as bool?,
      customerId: fields[2] as int?,
      downloadInvoice: fields[25] as String?,
      userId: fields[3] as int?,
      cartCount: fields[4] as int?,
      wishlistCount: fields[5] as int?,
      isEmailVerified: fields[6] as bool?,
      isSeller: fields[7] as bool?,
      sellerGroup: fields[8] as String?,
      sellerState: fields[9] as String?,
      name: fields[10] as String?,
      createDate: fields[11] as String?,
      amountTotal: fields[12] as String?,
      status: fields[13] as String?,
      amountUntaxed: fields[14] as String?,
      amountTax: fields[15] as String?,
      shippingAddress: fields[16] as String?,
      shipAddUrl: fields[17] as String?,
      billingAddress: fields[18] as String?,
      items: (fields[19] as List?)?.cast<OrderItems>(),
      delivery: fields[20] as Delivery?,
      pickingDetails: (fields[21] as List?)?.cast<PickingDetails>(),
      deliveryLatitude: fields[22] as String?,
      deliveryLongitude: fields[23] as String?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, OrderDetailModel obj) {
    writer
      ..writeByte(33)
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
      ..write(obj.name)
      ..writeByte(11)
      ..write(obj.createDate)
      ..writeByte(12)
      ..write(obj.amountTotal)
      ..writeByte(13)
      ..write(obj.status)
      ..writeByte(14)
      ..write(obj.amountUntaxed)
      ..writeByte(15)
      ..write(obj.amountTax)
      ..writeByte(16)
      ..write(obj.shippingAddress)
      ..writeByte(17)
      ..write(obj.shipAddUrl)
      ..writeByte(18)
      ..write(obj.billingAddress)
      ..writeByte(19)
      ..write(obj.items)
      ..writeByte(20)
      ..write(obj.delivery)
      ..writeByte(21)
      ..write(obj.pickingDetails)
      ..writeByte(22)
      ..write(obj.deliveryLatitude)
      ..writeByte(23)
      ..write(obj.deliveryLongitude)
      ..writeByte(24)
      ..write(obj.isOrderInvoiced)
      ..writeByte(25)
      ..write(obj.downloadInvoice)
      ..writeByte(26)
      ..write(obj.canReOrder)
      ..writeByte(27)
      ..write(obj.needCartMerge)
      ..writeByte(28)
      ..write(obj.id)
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
      other is OrderDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderItemsAdapter extends TypeAdapter<OrderItems> {
  @override
  final int typeId = 41;

  @override
  OrderItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderItems(
      name: fields[0] as String?,
      productName: fields[1] as String?,
      qty: fields[2] as String?,
      priceUnit: fields[3] as String?,
      priceSubtotal: fields[4] as String?,
      priceTax: fields[5] as String?,
      priceTotal: fields[6] as String?,
      discount: fields[7] as String?,
      state: fields[8] as String?,
      thumbNail: fields[9] as String?,
      templateId: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderItems obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.qty)
      ..writeByte(3)
      ..write(obj.priceUnit)
      ..writeByte(4)
      ..write(obj.priceSubtotal)
      ..writeByte(5)
      ..write(obj.priceTax)
      ..writeByte(6)
      ..write(obj.priceTotal)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.state)
      ..writeByte(9)
      ..write(obj.thumbNail)
      ..writeByte(10)
      ..write(obj.templateId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PickingDetailsAdapter extends TypeAdapter<PickingDetails> {
  @override
  final int typeId = 58;

  @override
  PickingDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PickingDetails(
      deliveryBoyId: fields[0] as int?,
      name: fields[1] as String?,
      status: fields[2] as String?,
      createDate: fields[3] as String?,
      scheduledDate: fields[4] as String?,
      lat: fields[5] as String?,
      long: fields[6] as String?,
      warehouseDetails: fields[7] as WarehouseDetails?,
    );
  }

  @override
  void write(BinaryWriter writer, PickingDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.deliveryBoyId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.createDate)
      ..writeByte(4)
      ..write(obj.scheduledDate)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.long)
      ..writeByte(7)
      ..write(obj.warehouseDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickingDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WarehouseDetailsAdapter extends TypeAdapter<WarehouseDetails> {
  @override
  final int typeId = 59;

  @override
  WarehouseDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WarehouseDetails(
      address: fields[0] as String?,
      lat: fields[1] as String?,
      long: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WarehouseDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WarehouseDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      canReOrder: json['canReOrder'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      needCartMerge: json['needCartMerge'] as bool?,
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      isOrderInvoiced: json['isOrderInvoiced'] as bool?,
      customerId: (json['customerId'] as num?)?.toInt(),
      downloadInvoice: json['download_invoice'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['WishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_tate'] as String?,
      name: json['name'] as String?,
      createDate: json['create_date'] as String?,
      amountTotal: json['amount_total'] as String?,
      status: json['status'] as String?,
      amountUntaxed: json['amount_untaxed'] as String?,
      amountTax: json['amount_tax'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      shipAddUrl: json['shipAdd_url'] as String?,
      billingAddress: json['billing_address'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      delivery: json['delivery'] == null
          ? null
          : Delivery.fromJson(json['delivery'] as Map<String, dynamic>),
      pickingDetails: (json['picking_details'] as List<dynamic>?)
          ?.map((e) => PickingDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryLatitude: json['delivery_latitude'] as String?,
      deliveryLongitude: json['delivery_longitude'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
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
      'WishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_tate': instance.sellerState,
      'name': instance.name,
      'create_date': instance.createDate,
      'amount_total': instance.amountTotal,
      'status': instance.status,
      'amount_untaxed': instance.amountUntaxed,
      'amount_tax': instance.amountTax,
      'shipping_address': instance.shippingAddress,
      'shipAdd_url': instance.shipAddUrl,
      'billing_address': instance.billingAddress,
      'items': instance.items,
      'delivery': instance.delivery,
      'picking_details': instance.pickingDetails,
      'delivery_latitude': instance.deliveryLatitude,
      'delivery_longitude': instance.deliveryLongitude,
      'isOrderInvoiced': instance.isOrderInvoiced,
      'download_invoice': instance.downloadInvoice,
      'canReOrder': instance.canReOrder,
      'needCartMerge': instance.needCartMerge,
      'id': instance.id,
    };

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
      name: json['name'] as String?,
      productName: json['product_name'] as String?,
      qty: json['qty'] as String?,
      priceUnit: json['price_unit'] as String?,
      priceSubtotal: json['price_subtotal'] as String?,
      priceTax: json['price_tax'] as String?,
      priceTotal: json['price_total'] as String?,
      discount: json['discount'] as String?,
      state: json['state'] as String?,
      thumbNail: json['thumbNail'] as String?,
      templateId: (json['templateId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product_name': instance.productName,
      'qty': instance.qty,
      'price_unit': instance.priceUnit,
      'price_subtotal': instance.priceSubtotal,
      'price_tax': instance.priceTax,
      'price_total': instance.priceTotal,
      'discount': instance.discount,
      'state': instance.state,
      'thumbNail': instance.thumbNail,
      'templateId': instance.templateId,
    };

PickingDetails _$PickingDetailsFromJson(Map<String, dynamic> json) =>
    PickingDetails(
      deliveryBoyId: (json['deliveryBoyId'] as num?)?.toInt(),
      name: json['name'] as String?,
      status: json['status'] as String?,
      createDate: json['create_date'] as String?,
      scheduledDate: json['scheduled_date'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      warehouseDetails: json['warehouse_details'] == null
          ? null
          : WarehouseDetails.fromJson(
              json['warehouse_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PickingDetailsToJson(PickingDetails instance) =>
    <String, dynamic>{
      'deliveryBoyId': instance.deliveryBoyId,
      'name': instance.name,
      'status': instance.status,
      'create_date': instance.createDate,
      'scheduled_date': instance.scheduledDate,
      'lat': instance.lat,
      'long': instance.long,
      'warehouse_details': instance.warehouseDetails,
    };

WarehouseDetails _$WarehouseDetailsFromJson(Map<String, dynamic> json) =>
    WarehouseDetails(
      address: json['address'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );

Map<String, dynamic> _$WarehouseDetailsToJson(WarehouseDetails instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lat': instance.lat,
      'long': instance.long,
    };
