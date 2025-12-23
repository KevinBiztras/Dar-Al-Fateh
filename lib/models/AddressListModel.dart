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

part 'AddressListModel.g.dart';

@HiveType(typeId: HiveTypeConstants.addressListModelHiveTypeId)
@JsonSerializable()
class AddressListModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
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
  int? tcount;
  @HiveField(7)
  List<Addresses>? addresses;
  @HiveField(8)
  @JsonKey(name: "default_shipping_address_id")
  Addresses? defaultShippingAddressId;

  AddressListModel(
      {this.itemsPerPage,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.tcount,
      this.addresses,
      this.defaultShippingAddressId});

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      _$AddressListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressListModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.addressListAddressesModelHiveTypeId)
@JsonSerializable()
class Addresses {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;
  @HiveField(2)
  int? addressId;
  @HiveField(3)
  @JsonKey(name: "display_name")
  String? displayName;

  Addresses({this.name, this.url, this.addressId, this.displayName});

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesToJson(this);
}
