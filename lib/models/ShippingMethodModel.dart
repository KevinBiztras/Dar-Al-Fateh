
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
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ShippingMethodModel.g.dart';

@HiveType(typeId: HiveTypeConstants.shippingMethodModelHiveTypeId)
@JsonSerializable()
class ShippingMethodModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  int? customerId;
  @HiveField(2)
  int? userId;
  @HiveField(3)
  int? cartCount;
  @HiveField(4)
  @JsonKey(name: "WishlistCount")
  int? wishlistCount;
  @HiveField(5)
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;
  @HiveField(6)
  @JsonKey(name: "ShippingMethods")
  List<ShippingMethods>? shippingMethods;
 
  ShippingMethodModel(
      {this.itemsPerPage,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.shippingMethods});

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.shippingMethodsHiveTypeId)
@JsonSerializable()
class ShippingMethods {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? price;

  ShippingMethods({this.name, this.id, this.description, this.price});

  factory ShippingMethods.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodsToJson(this);
}
