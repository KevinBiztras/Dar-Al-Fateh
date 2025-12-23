/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderDetailModel.g.dart';

@HiveType(typeId: HiveTypeConstants.orderDetailModelHiveTypeId)
@JsonSerializable()
class OrderDetailModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
  @HiveField(2)
  int? customerId;
  @HiveField(3)
  int? userId;
  @HiveField(4)
  int? cartCount;
  @HiveField(5)
  @JsonKey(name: "WishlistCount")
  int? wishlistCount;
  @HiveField(6)
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @HiveField(7)
  @JsonKey(name: "is_seller")
  bool? isSeller;
  @HiveField(8)
  @JsonKey(name: "seller_group")
  String? sellerGroup;
  @HiveField(9)
  @JsonKey(name: "seller_tate")
  String? sellerState;
  @HiveField(10)
  String? name;
  @HiveField(11)
  @JsonKey(name: "create_date")
  String? createDate;
  @HiveField(12)
  @JsonKey(name: "amount_total")
  String? amountTotal;
  @HiveField(13)
  String? status;
  @HiveField(14)
  @JsonKey(name: "amount_untaxed")
  String? amountUntaxed;
  @HiveField(15)
  @JsonKey(name: "amount_tax")
  String? amountTax;
  @HiveField(16)
  @JsonKey(name: "shipping_address")
  String? shippingAddress;
  @HiveField(17)
  @JsonKey(name: "shipAdd_url")
  String? shipAddUrl;
  @HiveField(18)
  @JsonKey(name: "billing_address")
  String? billingAddress;
  @HiveField(19)
  List<OrderItems>? items;
  @HiveField(20)
  Delivery? delivery;
  @HiveField(21)
  @JsonKey(name: "picking_details")
  List<PickingDetails>? pickingDetails;
  @HiveField(22)
  @JsonKey(name: 'delivery_latitude')
  final String? deliveryLatitude;
  @HiveField(23)
  @JsonKey(name: 'delivery_longitude')
  final String? deliveryLongitude;
  @HiveField(24)
  @JsonKey(name: 'isOrderInvoiced')
  final bool? isOrderInvoiced;
  @HiveField(25)
  @JsonKey(name: 'download_invoice')
  final String? downloadInvoice;
  @HiveField(26)
  final bool? canReOrder;
  @HiveField(27)
  final bool? needCartMerge;
  @HiveField(28)
  final int? id;

  OrderDetailModel({
    this.canReOrder,
    this.id,
    this.needCartMerge,
    this.itemsPerPage,
    this.addons,
    this.isOrderInvoiced,
    this.customerId,
    this.downloadInvoice,
    this.userId,
    this.cartCount,
    this.wishlistCount,
    this.isEmailVerified,
    this.isSeller,
    this.sellerGroup,
    this.sellerState,
    this.name,
    this.createDate,
    this.amountTotal,
    this.status,
    this.amountUntaxed,
    this.amountTax,
    this.shippingAddress,
    this.shipAddUrl,
    this.billingAddress,
    this.items,
    this.delivery,
    this.pickingDetails,
    this.deliveryLatitude,
    this.deliveryLongitude,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.orderDetailItemsModelHiveTypeId)
@JsonSerializable()
class OrderItems {
  @HiveField(0)
  String? name;
  @HiveField(1)
  @JsonKey(name: "product_name")
  String? productName;
  @HiveField(2)
  String? qty;
  @HiveField(3)
  @JsonKey(name: "price_unit")
  String? priceUnit;
  @HiveField(4)
  @JsonKey(name: "price_subtotal")
  String? priceSubtotal;
  @HiveField(5)
  @JsonKey(name: "price_tax")
  String? priceTax;
  @HiveField(6)
  @JsonKey(name: "price_total")
  String? priceTotal;
  @HiveField(7)
  String? discount;
  @HiveField(8)
  String? state;
  @HiveField(9)
  String? thumbNail;
  @HiveField(10)
  int? templateId;

  OrderItems(
      {this.name,
      this.productName,
      this.qty,
      this.priceUnit,
      this.priceSubtotal,
      this.priceTax,
      this.priceTotal,
      this.discount,
      this.state,
      this.thumbNail,
      this.templateId});

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}

@HiveType(typeId: HiveTypeConstants.orderDetailPickingDetailModelHiveTypeId)
@JsonSerializable()
class PickingDetails {
  @HiveField(0)
  int? deliveryBoyId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? status;
  @HiveField(3)
  @JsonKey(name: "create_date")
  String? createDate;
  @HiveField(4)
  @JsonKey(name: "scheduled_date")
  String? scheduledDate;
  @HiveField(5)
  String? lat;
  @HiveField(6)
  String? long;
  @HiveField(7)
  @JsonKey(name: 'warehouse_details')
  final WarehouseDetails? warehouseDetails;

  PickingDetails(
      {this.deliveryBoyId,
      this.name,
      this.status,
      this.createDate,
      this.scheduledDate,
      this.lat,
      this.long,
      this.warehouseDetails});

  factory PickingDetails.fromJson(Map<String, dynamic> json) =>
      _$PickingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PickingDetailsToJson(this);
}

@HiveType(
    typeId: HiveTypeConstants.orderDetailPickingWarehouseDetailModelHiveTypeId)
@JsonSerializable()
class WarehouseDetails {
  @HiveField(0)
  final String? address;
  @HiveField(1)
  final String? lat;
  @HiveField(2)
  final String? long;

  const WarehouseDetails({
    this.address,
    this.lat,
    this.long,
  });

  factory WarehouseDetails.fromJson(Map<String, dynamic> json) =>
      _$WarehouseDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseDetailsToJson(this);
}
