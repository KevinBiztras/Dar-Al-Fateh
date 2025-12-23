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
part 'WishlistModel.g.dart';


@HiveType(typeId: HiveTypeConstants.wishlistModelHiveTypeId)
@JsonSerializable()
class WishlistModel extends BaseModel{
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
  bool? isEmailVerified;
  @HiveField(7)
  List<WishListItems>? wishLists;

  WishlistModel(
      {
        this.itemsPerPage,
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.wishLists});

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);
}


@HiveType(typeId: HiveTypeConstants.wishlistItemsModelHiveTypeId)
@JsonSerializable()
class WishListItems{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? thumbNail;
  @HiveField(3)
  String? priceReduce;
  @HiveField(4)
  String? priceUnit;
  @HiveField(5)
  int? productId;
  @HiveField(6)
  int? templateId;

  WishListItems(
      {this.id,
        this.name,
        this.thumbNail,
        this.priceReduce,
        this.priceUnit,
        this.productId,
        this.templateId});

  factory WishListItems.fromJson(Map<String, dynamic> json) =>
      _$WishListItemsFromJson(json);

}