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

part 'ReviewListModel.g.dart';

@HiveType(typeId: HiveTypeConstants.reviewListModelHiveTypeId)
@JsonSerializable()
class ReviewListModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  @JsonKey(name: "product_reviews")
  List<ProductReviews>? productReviews;
  @HiveField(2)
  int? reviewCount;

  ReviewListModel({this.itemsPerPage, this.productReviews, this.reviewCount});

  factory ReviewListModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewListModelFromJson(json);

}

@HiveType(typeId: HiveTypeConstants.productReviewsModelHiveTypeId)
@JsonSerializable()
class ProductReviews {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? customer;
  @JsonKey(name: "customer_image")
  @HiveField(2)
  String? customerImage;
  @HiveField(3)
  String? email;
  @HiveField(4)
  int? likes;
  @HiveField(5)
  int? dislikes;
  @HiveField(6)
  double? rating;
  @HiveField(7)
  String? title;
  @HiveField(8)
  String? msg;
  @HiveField(9)
  @JsonKey(name: "create_date")
  String? createDate;
  @HiveField(10)
  @JsonKey(name: "write_date")
  String? writeDate;
  @HiveField(11)
  @JsonKey(name: "is_email_verified")
  bool? isEmailVerified;

  ProductReviews(
      {this.id,
      this.customer,
      this.customerImage,
      this.email,
      this.likes,
      this.dislikes,
      this.rating,
      this.title,
      this.msg,
      this.createDate,
      this.writeDate,
      this.isEmailVerified});

  factory ProductReviews.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewsFromJson(json);

}
