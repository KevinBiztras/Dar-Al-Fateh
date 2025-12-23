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
part 'AccountInfoModel.g.dart';

@HiveType(typeId: HiveTypeConstants.accountInfoModelHiveTypeId)
@JsonSerializable()
class AccountInfoModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
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
  @JsonKey(name: "is_seller")
  bool? isSeller;
  @HiveField(7)
  @JsonKey(name: "seller_group")
  String? sellerGroup;
  @HiveField(8)
  @JsonKey(name: "seller_state")
  String? sellerState;
  @HiveField(9)
  bool? downloadRequest;
  @HiveField(10)
  String? downloadMessage;
  @HiveField(11)
  String? downloadUrl;
  @HiveField(12)
  String? customerBannerImage;
  @HiveField(13)
  String? customerProfileImage;

  AccountInfoModel(
      {this.wishlistCount,
      this.sellerState,
      this.downloadRequest,
      this.sellerGroup,
      this.isSeller,
      this.isEmailVerified,
      this.cartCount,
      this.addons,
      this.userId,
      this.itemsPerPage,
      this.downloadMessage,
      this.downloadUrl,
      this.customerBannerImage,
      this.customerProfileImage});

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoModelToJson(this);
}
