import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:hive/hive.dart';

import 'BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HomeScreenModel.dart';
part 'OrderReviewModel.g.dart';

@HiveType(typeId: HiveTypeConstants.orderReviewModelHiveTypeId)
@JsonSerializable()
class OrderReviewModel extends BaseModel{
  @HiveField(0)
  Addons? addons;
  @HiveField(1)
  int? customerId;
  @HiveField(2)
  int? userId;
  @HiveField(3)
  int? cartCount;
  @HiveField(4)
  int? wishlistCount;
  @HiveField(5)
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @HiveField(6)
  PaymentTerms? paymentTerms;
  @HiveField(7)
  String? name;
  @HiveField(8)
  String? billingAddress;
  @HiveField(9)
  String? shippingAddress;
  @HiveField(10)
  String? paymentAcquirer;
  @HiveField(11)
  OrderReviewSubtotal? subtotal;
  @HiveField(12)
  OrderReviewSubtotal? tax;
  @HiveField(13)
  OrderReviewSubtotal? grandtotal;
  @HiveField(14)
  double? amount;
  @HiveField(15)
  String? currency;
  @HiveField(16)
  List<OrderReviewItems>? items;
  @HiveField(17)
  Delivery? delivery;
  @HiveField(18)
  PaymentData? paymentData;
  @HiveField(19)
  @JsonKey(name: "transaction_id")
  int? transactionId;
  @HiveField(20)
  List<String>? appliedCoupons;

  OrderReviewModel(
      {
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.paymentTerms,
        this.name,
        this.billingAddress,
        this.shippingAddress,
        this.paymentAcquirer,
        this.subtotal,
        this.tax,
        this.grandtotal,
        this.amount,
        this.currency,
        this.items,
        this.delivery,
        this.paymentData,
        this.appliedCoupons,
        this.transactionId});

  factory OrderReviewModel.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewModelFromJson(json);

}


@HiveType(typeId: HiveTypeConstants.paymentTermsModelHiveTypeId)
@JsonSerializable()
class PaymentTerms {
  @HiveField(0)
  String? paymentShortTerms;
  @HiveField(1)
  String? paymentLongTerms;

  PaymentTerms({this.paymentShortTerms, this.paymentLongTerms});

  factory PaymentTerms.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermsFromJson(json);

}

@HiveType(typeId: HiveTypeConstants.orderReviewSubtotalModelHiveTypeId)
@JsonSerializable()
class OrderReviewSubtotal {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? value;

  OrderReviewSubtotal({this.title, this.value});

  factory OrderReviewSubtotal.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewSubtotalFromJson(json);

}

@HiveType(typeId: HiveTypeConstants.orderReviewItemsModelHiveTypeId)
@JsonSerializable()
class OrderReviewItems {
  @HiveField(0)
  int? lineId;
  @HiveField(1)
  int? templateId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? thumbNail;
  @HiveField(4)
  String? priceReduce;
  @HiveField(5)
  String? priceUnit;
  @HiveField(6)
  double? qty;
  @HiveField(7)
  String? total;
  @HiveField(8)
  String? discount;
 @HiveField(9)
  bool? isEditable;

  OrderReviewItems(
      {this.lineId,
        this.templateId,
        this.name,
        this.thumbNail,
        this.priceReduce,
        this.priceUnit,
        this.qty,
        this.total,
        this.isEditable,
        this.discount});

  factory OrderReviewItems.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewItemsFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.deliveryModelHiveTypeId)
@JsonSerializable()
class Delivery {
  @HiveField(0)
  List<String>? tax;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? shippingId;
  @HiveField(4)
  String? total;

  Delivery(
      {this.tax, this.name, this.description, this.shippingId, this.total});

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);

}

@HiveType(typeId: HiveTypeConstants.paymentDataModelHiveTypeId)
@JsonSerializable()
class PaymentData {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  String? code;
  @HiveField(2)
  bool? auth;
  @HiveField(3)
  @JsonKey(name: "customer_email")
  var customerEmail;

  PaymentData({this.status, this.code, this.auth, this.customerEmail});

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

}