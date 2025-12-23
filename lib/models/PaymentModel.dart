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
import 'HomeScreenModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PaymentModel.g.dart';

@HiveType(typeId: HiveTypeConstants.paymentModelHiveTypeId)
@JsonSerializable()
class PaymentModel extends BaseModel{
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
  List<Acquirers>? acquirers;

  PaymentModel(
      {
        this.itemsPerPage,
        this.addons,
        this.customerId,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.isEmailVerified,
        this.acquirers});

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.paymentAcquirersModelHiveTypeId)
@JsonSerializable()
class Acquirers{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? thumbNail;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? code;
  @HiveField(5)
  String? extraKey;

  Acquirers(
      {this.id,
        this.name,
        this.thumbNail,
        this.description,
        this.code,
        this.extraKey});

  factory Acquirers.fromJson(Map<String, dynamic> json) =>
      _$AcquirersFromJson(json);
}


