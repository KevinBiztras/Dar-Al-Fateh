/*

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../local_database/hive_type.dart';
part 'FilterDataModel.g.dart';

@HiveType(typeId: HiveTypeConstants.getFilterAttributeHiveTypeId)
@JsonSerializable()
class GetFilterAttribute {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  int? responseCode;
  @HiveField(2)
  int? offset;
  @HiveField(3)
  String? message;
  @HiveField(4)
  int? itemsPerPage;
  @HiveField(5)
  Addons? addons;
  @HiveField(6)
  int? customerId;
  @HiveField(7)
  int? userId;
  @HiveField(8)
  int? applied_category_id;
  @HiveField(9)
  int? cartCount;
  @HiveField(10)
  int? wishlistCount;
  @HiveField(11)
  List<Categories>? categories;
  @HiveField(12)
  List<Filters>? filters;
  @HiveField(13)
  @JsonKey(name: "available_max_price")
  double?  availableMaxPrice;
  @HiveField(14)
  bool?  is_price_filter_available;
  @HiveField(15)
  @JsonKey(name: "total_product_count")
  int? total_product_count;
  @HiveField(16)
  @JsonKey(name: "tcount")
  int? tcount;
  @HiveField(17)
  List<AppliedFilters>? applied_filters;
  @HiveField(18)
  List<Products>? products;
  @HiveField(19)
  bool? isPriceFilterAvailable;
  @HiveField(20)
  double? min_price;
  @HiveField(21)
  double? max_price;
  @HiveField(22)
  @JsonKey(name: "available_min_price")
  double? availableMinPrice;
  @HiveField(23)
  List<int>? wishlist;


  GetFilterAttribute(
      {this.success,
        this.responseCode,this.applied_category_id,
        this.message,
        this.offset,
        this.itemsPerPage,
        this.applied_filters,
        this.addons,
        this.is_price_filter_available ,
        this.customerId,
        this.isPriceFilterAvailable,
        this.userId,
        this.cartCount,
        this.wishlistCount,
        this.categories,
        this.filters,
        this.wishlist,
        this.total_product_count,
        this.products,

        this.min_price,
        this.max_price,
        this.availableMinPrice,
        this.availableMaxPrice});

  factory GetFilterAttribute.fromJson(Map<String, dynamic> json) =>
      _$GetFilterAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$GetFilterAttributeToJson(this);
}

@HiveType(typeId: HiveTypeConstants.filterHiveTypeId)
@JsonSerializable()
class Filters {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  @JsonKey(name: "display_type",defaultValue: "")
  String? displayType;
  @HiveField(3)
  @JsonKey(name: "attribute_value")
  List<AttributeValue>? attributeValue;

  Filters({this.id, this.name, this.displayType, this.attributeValue});

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}

@HiveType(typeId: HiveTypeConstants.attributeValueHiveTypeId)
@JsonSerializable()
class AttributeValue {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  @JsonKey(name: "color_code")
  String? colorCode;
  @HiveField(3)
  @JsonKey(name: "product_count",defaultValue: 0)
  int ? product_count;
  @HiveField(4)
  List<AttributeValue>? attributeValue;
  @HiveField(5)
  bool? isChecked = false;


  AttributeValue({this.id, this.name, this.colorCode,this.attributeValue,this.isChecked});

  factory AttributeValue.fromJson(Map<String, dynamic> json) =>
      _$AttributeValueFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeValueToJson(this);
}


@HiveType(typeId: HiveTypeConstants.appliedFiltersHiveTypeId)
@JsonSerializable()
class AppliedFilters {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  List<AppliedFiltersValue>? applied_filters_value;

  AppliedFilters({this.id, this.name, this.applied_filters_value});




  factory AppliedFilters.fromJson(Map<String, dynamic> json) =>
      _$AppliedFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedFiltersToJson(this);

}

@HiveType(typeId: HiveTypeConstants.appliedFiltersValueHiveTypeId)
@JsonSerializable()
class AppliedFiltersValue {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  @JsonKey(name: "color_code")
  String? colorCode;
  @HiveField(3)
  bool? isChecked = false;


  AppliedFiltersValue({this.id, this.name, this.colorCode,this.isChecked});

  factory AppliedFiltersValue.fromJson(Map<String, dynamic> json) =>
      _$AppliedFiltersValueFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedFiltersValueToJson(this);
}
