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
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SearchScreenModel.g.dart';

@HiveType(typeId: HiveTypeConstants.searchScreenModelHiveTypeId)
@JsonSerializable()
class SearchScreenModel extends BaseModel {
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
  @JsonKey(name: "wishlistCount")
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
  @JsonKey(name: "seller_state")
  String? sellerState;
  @HiveField(10)
  int? tcount;
  @HiveField(11)
  int? offset;
  @HiveField(12)
  List<Products>? products;
  @HiveField(13)
  List<int>? wishlist;
  SearchScreenModel({
    this.isEmailVerified, this.customerId,this.itemsPerPage, this.wishlistCount,this.sellerState, this.sellerGroup, this.isSeller, this.cartCount,
    this.addons, this.userId, this.offset, this.tcount, this.products, this.wishlist
});

  factory SearchScreenModel.fromJson(Map<String, dynamic> json) => _$SearchScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchScreenModelToJson(this);

}


