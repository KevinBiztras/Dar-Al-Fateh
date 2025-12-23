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
import 'HomeScreenModel.dart';

part 'CartViewModel.g.dart';

@HiveType(typeId: HiveTypeConstants.cartViewModelHiveTypeId)
@JsonSerializable()
class CartViewModel extends BaseModel{
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
  String? name;
  @HiveField(8)
  Subtotal? subtotal;
  @HiveField(9)
  Subtotal? tax;
  @HiveField(10)
  Subtotal? grandtotal;
  @HiveField(11)
  List<Items>? items;
  @HiveField(12)
  List<Accessories>?accessoriesProducts;

  CartViewModel(
      {
        this.itemsPerPage,
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.name,
        this.subtotal,
        this.tax,
        this.grandtotal,
        this.items, this.accessoriesProducts});

  factory CartViewModel.fromJson(Map<String, dynamic> json) =>
      _$CartViewModelFromJson(json);
}
@HiveType(typeId: HiveTypeConstants.accessoriesDataTypeId)
@JsonSerializable()
class Accessories{
  @HiveField(0)
  int? templateId;
  @HiveField(1)
  int? productId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? priceUnit;
  @HiveField(4)
  String? image;
  Accessories(this.templateId, this.productId, this.name, this.priceUnit, this.image);

  factory Accessories.fromJson(Map<String, dynamic> json) =>
      _$AccessoriesFromJson(json);
}


@HiveType(typeId: HiveTypeConstants.cartViewSubtotalModelHiveTypeId)
@JsonSerializable()
class Subtotal{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? value;

  Subtotal({this.title, this.value});

  factory Subtotal.fromJson(Map<String, dynamic> json) =>
      _$SubtotalFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.cartViewItemsModelHiveTypeId)
@JsonSerializable()
class Items{
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

  Items(
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

  factory Items.fromJson(Map<String, dynamic> json) =>
      _$ItemsFromJson(json);
}