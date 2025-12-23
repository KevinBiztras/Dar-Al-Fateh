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
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:hive/hive.dart';
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

import 'HomeScreenModel.dart';

part 'ProductScreenModel.g.dart';


@HiveType(typeId: HiveTypeConstants.productPageModelHiveTypeId)
@JsonSerializable()
class ProductScreenModel extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
  @HiveField(2)
  int? templateId;
  @HiveField(3)
  String? name;
  @HiveField(4)
  List<String>? images;
  @HiveField(5)
  @JsonKey(name: "avg_rating")
  double? avgRating;
  @HiveField(6)
  @JsonKey(name: "total_review")
  int? totalReview;
  @HiveField(7)
  String? priceUnit;
  @HiveField(8)
  String? priceReduce;
  @HiveField(9)
  var productId;
  @HiveField(10)
  int? productCount;
  @HiveField(11)
  String? description;
  @HiveField(12)
  List<AlternativeProducts>? alternativeProducts;
  @HiveField(13)
  @JsonKey(name: "ar_ios")
  String? arIos;
  @HiveField(14)
  @JsonKey(name: "ar_android")
  String? arAndroid;
  @HiveField(15)
  String? thumbNail;
  @HiveField(16)
  String? absoluteUrl;
  @HiveField(17)
  bool? addedToWishlist;
  @HiveField(18)
  @JsonKey(name: "add_to_cart")
  bool? addToCart;
  @HiveField(19)
  @JsonKey(name: "stock_display_msg")
  String? stockDisplayMsg;
  @HiveField(20)
  final List<Attribute>? attributes;
  @HiveField(21)
  final List<ProductScreenModel>? variants;
  @HiveField(22)
  final List<Combinations>? combinations;

  ProductScreenModel(
      this.templateId,
      this.name,
      this.attributes,
      this.thumbNail,
      this.absoluteUrl,
      this.addedToWishlist,
      this.addToCart,
      this.alternativeProducts,
      this.arAndroid,
      this.arIos,
      this.avgRating,
      this.description,
      this.images,
      this.itemsPerPage,
      this.priceReduce,
      this.priceUnit,
      this.productCount,
      this.productId,
      this.stockDisplayMsg,
      this.totalReview,
      this.variants,
      this.combinations);

  factory ProductScreenModel.fromJson(Map<String, dynamic> json) =>
      _$ProductScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductScreenModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.productPageAttributeModelHiveTypeId)
@JsonSerializable()
class Attribute {
  @HiveField(0)
  int? attributeId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? newVariant;
  @HiveField(3)
  String? type;
  @HiveField(4)
  List<Values>? values;

  Attribute(
      {this.name, this.type, this.values, this.attributeId, this.newVariant});

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}

@HiveType(typeId: HiveTypeConstants.productPageValuesModelHiveTypeId)
@JsonSerializable()
class Values {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? valueId;
  @HiveField(2)
  String? htmlCode;
  @HiveField(3)
  String? newVariant;
  bool? isSelected = false; //----Local Use

  Values({this.newVariant, this.name, this.htmlCode, this.valueId});

  factory Values.fromJson(Map<String, dynamic> json) => _$ValuesFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesToJson(this);
}

@HiveType(typeId: HiveTypeConstants.productPageAlternativeProductsModelHiveTypeId)
@JsonSerializable()
class AlternativeProducts {
  @HiveField(0)
  int? templateId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? priceUnit;
  @HiveField(4)
  String? priceReduce;

  AlternativeProducts(this.name, this.image, this.templateId, this.priceReduce, this.priceUnit);

  factory AlternativeProducts.fromJson(Map<String, dynamic> json) =>
      _$AlternativeProductsFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeProductsToJson(this);
}

@HiveType(typeId: HiveTypeConstants.productPageVariantsModelHiveTypeId)
@JsonSerializable()
class Variants {
  @HiveField(0)
  int? productId;
  @HiveField(1)
  List<String>? images;
  @HiveField(2)
  @JsonKey(name: "ar_ios")
  String? arIos;
  @HiveField(3)
  @JsonKey(name: "ar_ android")
  String? arAndroid;
  @HiveField(4)
  String? absoluteUrl;
  @HiveField(5)
  String? priceReduce;
  @HiveField(6)
  String? priceUnit;
  @HiveField(7)
  List<Combinations>? combinations;
  @HiveField(8)
  bool? addedToWishlist;
  @HiveField(9)
  @JsonKey(name: "add_to_cart")
  bool? addToCart;
  @HiveField(10)
  @JsonKey(name: "stock_display_msg")
  String? stockDisplayMsg;


  Variants(
      {this.productId,
      this.priceReduce,
      this.stockDisplayMsg,
      this.priceUnit,
      this.images,
      this.arIos,
      this.arAndroid,
      this.addToCart,
      this.absoluteUrl,
      this.addedToWishlist,
      this.combinations});

  factory Variants.fromJson(Map<String, dynamic> json) =>
      _$VariantsFromJson(json);

  Map<String, dynamic> toJson() => _$VariantsToJson(this);
}

@HiveType(typeId: HiveTypeConstants.productPageCombinationsModelHiveTypeId)
@JsonSerializable()
class Combinations extends Equatable {
  @HiveField(0)
  int? valueId;
  @HiveField(1)
  int? attributeId;

  Combinations({this.valueId, this.attributeId});

  factory Combinations.fromJson(Map<String, dynamic> json) =>
      _$CombinationsFromJson(json);

  Map<String, dynamic> toJson() => _$CombinationsToJson(this);

  @override
  List<Object?> get props => [valueId, attributeId];
}
