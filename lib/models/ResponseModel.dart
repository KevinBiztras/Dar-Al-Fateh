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

import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ResponseModel.g.dart';

@JsonSerializable()
class ResponseModel extends BaseModel{
Addons? addons;
int? customerId;
int? userId;
int? cartCount;
int? wishlistCount;
bool? isEmailVerified;
String? productName;

ResponseModel({this.addons,this.cartCount,this.customerId,this.isEmailVerified,this.productName,this.userId,this.wishlistCount});

factory ResponseModel.fromJson(Map<String, dynamic> json) =>
    _$ResponseModelFromJson(json);


}