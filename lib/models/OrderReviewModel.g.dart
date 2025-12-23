// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderReviewModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderReviewModelAdapter extends TypeAdapter<OrderReviewModel> {
  @override
  final int typeId = 31;

  @override
  OrderReviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderReviewModel(
      addons: fields[0] as Addons?,
      customerId: fields[1] as int?,
      userId: fields[2] as int?,
      cartCount: fields[3] as int?,
      wishlistCount: fields[4] as int?,
      isEmailVerified: fields[5] as bool?,
      paymentTerms: fields[6] as PaymentTerms?,
      name: fields[7] as String?,
      billingAddress: fields[8] as String?,
      shippingAddress: fields[9] as String?,
      paymentAcquirer: fields[10] as String?,
      subtotal: fields[11] as OrderReviewSubtotal?,
      tax: fields[12] as OrderReviewSubtotal?,
      grandtotal: fields[13] as OrderReviewSubtotal?,
      amount: fields[14] as double?,
      currency: fields[15] as String?,
      items: (fields[16] as List?)?.cast<OrderReviewItems>(),
      delivery: fields[17] as Delivery?,
      paymentData: fields[18] as PaymentData?,
      appliedCoupons: (fields[20] as List?)?.cast<String>(),
      transactionId: fields[19] as int?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, OrderReviewModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.addons)
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
      ..write(obj.paymentTerms)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.billingAddress)
      ..writeByte(9)
      ..write(obj.shippingAddress)
      ..writeByte(10)
      ..write(obj.paymentAcquirer)
      ..writeByte(11)
      ..write(obj.subtotal)
      ..writeByte(12)
      ..write(obj.tax)
      ..writeByte(13)
      ..write(obj.grandtotal)
      ..writeByte(14)
      ..write(obj.amount)
      ..writeByte(15)
      ..write(obj.currency)
      ..writeByte(16)
      ..write(obj.items)
      ..writeByte(17)
      ..write(obj.delivery)
      ..writeByte(18)
      ..write(obj.paymentData)
      ..writeByte(19)
      ..write(obj.transactionId)
      ..writeByte(20)
      ..write(obj.appliedCoupons)
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
      other is OrderReviewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentTermsAdapter extends TypeAdapter<PaymentTerms> {
  @override
  final int typeId = 32;

  @override
  PaymentTerms read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentTerms(
      paymentShortTerms: fields[0] as String?,
      paymentLongTerms: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentTerms obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.paymentShortTerms)
      ..writeByte(1)
      ..write(obj.paymentLongTerms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTermsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderReviewSubtotalAdapter extends TypeAdapter<OrderReviewSubtotal> {
  @override
  final int typeId = 33;

  @override
  OrderReviewSubtotal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderReviewSubtotal(
      title: fields[0] as String?,
      value: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderReviewSubtotal obj) {
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
      other is OrderReviewSubtotalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderReviewItemsAdapter extends TypeAdapter<OrderReviewItems> {
  @override
  final int typeId = 34;

  @override
  OrderReviewItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderReviewItems(
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
  void write(BinaryWriter writer, OrderReviewItems obj) {
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
      other is OrderReviewItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeliveryAdapter extends TypeAdapter<Delivery> {
  @override
  final int typeId = 35;

  @override
  Delivery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Delivery(
      tax: (fields[0] as List?)?.cast<String>(),
      name: fields[1] as String?,
      description: fields[2] as String?,
      shippingId: fields[3] as int?,
      total: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Delivery obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tax)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.shippingId)
      ..writeByte(4)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentDataAdapter extends TypeAdapter<PaymentData> {
  @override
  final int typeId = 36;

  @override
  PaymentData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentData(
      status: fields[0] as bool?,
      code: fields[1] as String?,
      auth: fields[2] as bool?,
      customerEmail: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.auth)
      ..writeByte(3)
      ..write(obj.customerEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReviewModel _$OrderReviewModelFromJson(Map<String, dynamic> json) =>
    OrderReviewModel(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      paymentTerms: json['paymentTerms'] == null
          ? null
          : PaymentTerms.fromJson(json['paymentTerms'] as Map<String, dynamic>),
      name: json['name'] as String?,
      billingAddress: json['billingAddress'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      paymentAcquirer: json['paymentAcquirer'] as String?,
      subtotal: json['subtotal'] == null
          ? null
          : OrderReviewSubtotal.fromJson(
              json['subtotal'] as Map<String, dynamic>),
      tax: json['tax'] == null
          ? null
          : OrderReviewSubtotal.fromJson(json['tax'] as Map<String, dynamic>),
      grandtotal: json['grandtotal'] == null
          ? null
          : OrderReviewSubtotal.fromJson(
              json['grandtotal'] as Map<String, dynamic>),
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderReviewItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      delivery: json['delivery'] == null
          ? null
          : Delivery.fromJson(json['delivery'] as Map<String, dynamic>),
      paymentData: json['paymentData'] == null
          ? null
          : PaymentData.fromJson(json['paymentData'] as Map<String, dynamic>),
      appliedCoupons: (json['appliedCoupons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      transactionId: (json['transaction_id'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$OrderReviewModelToJson(OrderReviewModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'paymentTerms': instance.paymentTerms,
      'name': instance.name,
      'billingAddress': instance.billingAddress,
      'shippingAddress': instance.shippingAddress,
      'paymentAcquirer': instance.paymentAcquirer,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'grandtotal': instance.grandtotal,
      'amount': instance.amount,
      'currency': instance.currency,
      'items': instance.items,
      'delivery': instance.delivery,
      'paymentData': instance.paymentData,
      'transaction_id': instance.transactionId,
      'appliedCoupons': instance.appliedCoupons,
    };

PaymentTerms _$PaymentTermsFromJson(Map<String, dynamic> json) => PaymentTerms(
      paymentShortTerms: json['paymentShortTerms'] as String?,
      paymentLongTerms: json['paymentLongTerms'] as String?,
    );

Map<String, dynamic> _$PaymentTermsToJson(PaymentTerms instance) =>
    <String, dynamic>{
      'paymentShortTerms': instance.paymentShortTerms,
      'paymentLongTerms': instance.paymentLongTerms,
    };

OrderReviewSubtotal _$OrderReviewSubtotalFromJson(Map<String, dynamic> json) =>
    OrderReviewSubtotal(
      title: json['title'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$OrderReviewSubtotalToJson(
        OrderReviewSubtotal instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };

OrderReviewItems _$OrderReviewItemsFromJson(Map<String, dynamic> json) =>
    OrderReviewItems(
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

Map<String, dynamic> _$OrderReviewItemsToJson(OrderReviewItems instance) =>
    <String, dynamic>{
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

Delivery _$DeliveryFromJson(Map<String, dynamic> json) => Delivery(
      tax: (json['tax'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      shippingId: (json['shippingId'] as num?)?.toInt(),
      total: json['total'] as String?,
    );

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'tax': instance.tax,
      'name': instance.name,
      'description': instance.description,
      'shippingId': instance.shippingId,
      'total': instance.total,
    };

PaymentData _$PaymentDataFromJson(Map<String, dynamic> json) => PaymentData(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      auth: json['auth'] as bool?,
      customerEmail: json['customer_email'],
    );

Map<String, dynamic> _$PaymentDataToJson(PaymentData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'auth': instance.auth,
      'customer_email': instance.customerEmail,
    };
