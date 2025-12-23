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
part 'NotificationModel.g.dart';

@HiveType(typeId: HiveTypeConstants.notificationModelHiveTypeId)
@JsonSerializable()
class NotificationModel extends BaseModel {
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
  @JsonKey(name: "all_notification_messages")
  List<NotificationList>? notificationList;

  NotificationModel(
      {this.userId,
      this.addons,
      this.cartCount,
      this.isEmailVerified,
      this.isSeller,
      this.sellerGroup,
      this.sellerState,
      this.wishlistCount,
      this.itemsPerPage,
      this.customerId,
      this.notificationList});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.notificationListModelHiveTypeId)
@JsonSerializable()
class NotificationList {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? subtitle;
  @HiveField(4)
  String? body;
  @HiveField(5)
  String? banner;
  @HiveField(6)
  String? icon;
  @HiveField(7)
  String? period;
  @HiveField(8)
  @JsonKey(name: "datatype")
  String? dataType;
  @HiveField(9)
  @JsonKey(name: "is_reade")
  bool? isRead;

  NotificationList(
      {this.body,
      this.name,
      this.id,
      this.icon,
      this.title,
      this.banner,
      this.dataType,
      this.isRead,
      this.period,
      this.subtitle});

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      _$NotificationListFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListToJson(this);

}