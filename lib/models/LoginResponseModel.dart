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

// ignore_for_file: file_names

/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LoginResponseModel.g.dart';


@JsonSerializable()
class LoginResponseModel extends BaseModel{
  int? itemPerPage;
  int? customerId;
  int? userId;
  int? cartCount;
  @JsonKey(name:"WishlistCount")
  int? wishListCount;
  @JsonKey(name:"is_email_verified")
  bool? isEmailVerified;
  String? customerBannerImage;
  String? customerProfileImage;
  var cartId;
  String? themeCode;
  String? customerName;
  String? customerEmail;
  String? customerLang;
  @JsonKey(name: "is_seller")
  bool? isSeller;

  LoginResponseModel({this.wishListCount, this.themeCode, this.isEmailVerified, this.customerProfileImage, this.customerLang, this.customerBannerImage, this.cartId, this.cartCount, this.customerEmail, this.customerName, this.customerId, this.userId, this.itemPerPage, this.isSeller});


  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);



}