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

part 'AddressDetailModel.g.dart';

@HiveType(typeId: HiveTypeConstants.addressDetailModelHiveTypeId)
@JsonSerializable()
class AddressDetailModel extends BaseModel {
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
  @JsonKey(name: "is_seller")
  bool? isSeller;
  @HiveField(7)
  String? name;
  @HiveField(8)
  String? street;
  @HiveField(9)
  String? zip;
  @HiveField(10)
  String? city;
  @HiveField(11)
  @JsonKey(name: "state_id")
  var stateId;
  @HiveField(12)
  @JsonKey(name: "country_id")
  var countryId;
  @HiveField(13)
  String? phone;

  AddressDetailModel(
      {this.itemsPerPage,
      this.customerId,
      this.userId,
      this.cartCount,
      this.wishlistCount,
      this.isEmailVerified,
      this.isSeller,
      this.name,
      this.street,
      this.zip,
      this.city,
      this.stateId,
      this.countryId,
      this.phone});

  factory AddressDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AddressDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailModelToJson(this);
}
int fromJson(dynamic json){
  int stateId = -1;
  if(json != null){
    if(json['state_id'] != null){
      stateId = json['state_id'];
    }
  }
  return stateId;
}
