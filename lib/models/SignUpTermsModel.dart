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

part 'SignUpTermsModel.g.dart';

@HiveType(typeId: HiveTypeConstants.signUpTermsModelHiveTypeId)
@JsonSerializable()
class SignUpTermsModel extends BaseModel{
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
  @HiveField(2)
 String? termsAndConditions;
  @HiveField(3)
 @JsonKey(name:"term_and_condition" )

 String? sellerTermsAndConditions;
 SignUpTermsModel({this.itemsPerPage, this.addons, this.termsAndConditions});
  factory SignUpTermsModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpTermsModelToJson(this);
}