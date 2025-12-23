/*
 * *
 *
 *  Webkul Software.
 *
 *  @package Mobikul App
 *
 *  @Category Mobikul
 *
 *  @author Webkul <support@webkul.com>
 *
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *
 *  @license https://store.webkul.com/license.html ASL Licence
 *
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BaseModel.g.dart';


@HiveType(typeId: HiveTypeConstants.baseModelHiveTypeId)
@JsonSerializable()
class BaseModel{
  @HiveField(100)
  bool? success;
  @HiveField(101)
  int? responseCode;
  @HiveField(102)
  String? message;
  @HiveField(103)
  bool? accessDenied;
  @HiveField(104)
  int? cartCount;

  BaseModel({this.success,this.responseCode,this.message, this.accessDenied,this.cartCount});

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}