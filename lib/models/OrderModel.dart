import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'HomeScreenModel.dart';
part 'OrderModel.g.dart';

@HiveType(typeId: HiveTypeConstants.orderModelHiveTypeId)
@JsonSerializable()
class OrderModel extends BaseModel {
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
  @JsonKey(name: "seller_state")
  String? sellerState;
  @HiveField(10)
  int? tcount;
  @HiveField(11)
  List<RecentOrders>? recentOrders;

  OrderModel(
      {this.customerId,
      this.userId,
      this.addons,
      this.cartCount,
      this.isEmailVerified,
      this.isSeller,
      this.itemsPerPage,
      this.recentOrders,
      this.sellerGroup,
      this.sellerState,
      this.tcount,
      this.wishlistCount});
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.recentOrdersModelHiveTypeId)
@JsonSerializable()
class RecentOrders {
  @HiveField(0)
  @JsonKey(name: "amount_total")
  String? amountTotal;
  @HiveField(1)
  bool? canReOrder;
  @HiveField(2)
  @JsonKey(name: "create_date")
  String? createDate;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? name;
  @HiveField(5)
  @JsonKey(name: "shipAdd_url")
  String? shippingAddressUrl;
  @HiveField(6)
  @JsonKey(name: "shipping_address")
  String? shippingAddress;
  @HiveField(7)
  String? status;
  @HiveField(8)
  String? url;
  @HiveField(9)
  bool? needCartMerge;

  RecentOrders(
      {this.url,
      this.name,
      this.needCartMerge,
      this.id,
      this.amountTotal,
      this.canReOrder,
      this.createDate,
      this.shippingAddress,
      this.shippingAddressUrl,
      this.status});
  factory RecentOrders.fromJson(Map<String, dynamic> json) =>
      _$RecentOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$RecentOrdersToJson(this);

}