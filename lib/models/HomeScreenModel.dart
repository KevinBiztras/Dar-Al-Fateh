/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'dart:convert';

import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HomeScreenModel.g.dart';

@HiveType(typeId: HiveTypeConstants.homePageModelHiveTypeId)
@JsonSerializable()
class HomePageData extends BaseModel {
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
  @HiveField(2)
  List<String>? defaultLanguage;
  @HiveField(3)
  @JsonKey(name: "TermsAndConditions")
  bool? termsAndConditions;
  @HiveField(4)
  List<Categories>? categories;
  @HiveField(5)
  List<List<String>>? allLanguages;
  @HiveField(6)
  List<String>? defaultPricelist;
  @HiveField(7)
  @JsonKey(name: "cartCount")
  int? cartCount;
  @HiveField(10)
  int? homepageDataCount;
  @HiveField(8)
  List<List<String>>? allPricelists;
  @HiveField(9)
  @JsonKey(name: "homepageData", defaultValue: [])
  @HiveField(11)
  List<HomepageDataList>? homepageDataList;
  @HiveField(12)
  @JsonKey(name: "wishlist")
  List<int>? wishlist;

  HomePageData({
    this.addons,
    this.homepageDataCount,
    this.itemsPerPage,
    this.termsAndConditions,
    this.categories,
    this.defaultLanguage,
    this.homepageDataList,
    this.cartCount,
    this.wishlist,
    this.defaultPricelist,
    this.allLanguages,
    this.allPricelists,
  });

  factory HomePageData.fromJson(Map<String, dynamic> json) =>
      _$HomePageDataFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.homePageBannerImagesModelHiveTypeId)
@JsonSerializable()
class HomepageDataList {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? type;
  @HiveField(2)
  List<Data>? data;
  @HiveField(3)
  @JsonKey(name: "featured_category_view_type")
  String? featuredCategoryViewType;

  HomepageDataList({
    this.name,
    this.type,
    this.data,
    this.featuredCategoryViewType,
  });

  factory HomepageDataList.fromJson(Map<String, dynamic> json) =>
      _$HomepageDataListFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.homePageFeaturedCategoriesModelHiveTypeId)
@JsonSerializable()
class Data {
  @HiveField(0)
  String? categoryName;
  @HiveField(1)
  int? categoryId;
  @HiveField(2)
  String? url;
  @HiveField(3)
  String? bannerName;
  @HiveField(4)
  String? bannerType;
  @HiveField(5)
  dynamic id;
  @HiveField(6)
  String? title;
  @HiveField(7)
  String? domain;
  @HiveField(8)
  @JsonKey(name: "item_display_limit")
  int? itemDisplayLimit;
  @HiveField(9)
  @JsonKey(name: "slider_mode")
  String? sliderMode;
  @HiveField(10)
  List<Products>? products;

  Data({
    this.categoryName,
    this.categoryId,
    this.url,
    this.bannerName,
    this.bannerType,
    this.id,
    this.title,
    this.domain,
    this.itemDisplayLimit,
    this.sliderMode,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.homePageAddonsModelHiveTypeId)
@JsonSerializable()
class Addons {
  @HiveField(0)
  bool? wishlist;
  @HiveField(1)
  bool? review;
  @HiveField(2)
  @JsonKey(name: "email_verification")
  bool? emailVerification;
  @HiveField(3)
  @JsonKey(name: "odoo_marketplace")
  bool? odooMarketplace;
  @HiveField(4)
  @JsonKey(name: "website_sale_delivery")
  bool? websiteSaleDelivery;
  @HiveField(5)
  @JsonKey(name: "odoo_gdpr")
  bool? odooGdpr;
  @HiveField(6)
  @JsonKey(name: "website_sale_stock")
  bool? websiteSaleStock;
  @HiveField(7)
  @JsonKey(name: "odoo_watch_app")
  bool? odooWatchApp;
  @HiveField(8)
  @JsonKey(name: "website_sale_comparison")
  bool? websiteSaleComparison;

  Addons({
    this.wishlist,
    this.review,
    this.emailVerification,
    this.odooGdpr,
    this.odooMarketplace,
    this.websiteSaleDelivery,
    this.websiteSaleStock,
    this.odooWatchApp,
    this.websiteSaleComparison,
  });

  factory Addons.fromJson(Map<String, dynamic> json) => _$AddonsFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsToJson(this);
}

@HiveType(typeId: HiveTypeConstants.homePageCategoriesModelHiveTypeId)
@JsonSerializable()
class Categories {
  @HiveField(0)
  @JsonKey(name: "category_id")
  int? categoryId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<Categories>? children;
  @HiveField(3)
  String? icon;
  @HiveField(4)
  @JsonKey(name: "display_type", defaultValue: "")
  String? displayType;
  @HiveField(6)
  @JsonKey(name: "color_code", defaultValue: "")
  String? colorCode;
  @JsonKey(name: "product_count", defaultValue: 0)
  int? product_count;

  Categories({
    this.categoryId,
    this.name,
    this.children,
    this.icon,
    this.displayType,
    this.colorCode,
    this.product_count,
  });

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.homePageProductsModelHiveTypeId)
@JsonSerializable()
class Products {
  @HiveField(0)
  int? templateId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? priceUnit;
  @HiveField(3)
  String? priceReduce;
  @HiveField(4)
  int? productId;
  @HiveField(5)
  int? productCount;
  @HiveField(6)
  String? description;
  @HiveField(7)
  String? thumbNail;
  @HiveField(8)
  Ribbon? ribbon;

  Products({
    this.templateId,
    this.ribbon,
    this.name,
    this.priceUnit,
    this.priceReduce,
    this.productId,
    this.productCount,
    this.description,
    this.thumbNail,
  });

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@HiveType(typeId: 60)
@JsonSerializable()
class Ribbon {
  @HiveField(1)
  @JsonKey(name: "ribbon_message")
  String? ribbonMessage;
  @HiveField(2)
  String? position;
  @HiveField(3)
  @JsonKey(name: "text_color")
  String? textColor;
  @HiveField(4)
  @JsonKey(name: "bg_color")
  String? bgColor;

  Ribbon({this.bgColor, this.position, this.ribbonMessage, this.textColor});

  factory Ribbon.fromJson(Map<String, dynamic> json) => _$RibbonFromJson(json);

  Map<String, dynamic> toJson() => _$RibbonToJson(this);
}

@HiveType(typeId: HiveTypeConstants.homePageChildrenModelHiveTypeId)
@JsonSerializable()
class Children {
  @HiveField(0)
  @JsonKey(name: "category_id")
  int? categoryId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<Children>? children;
  @HiveField(3)
  String? icon;

  Children({this.categoryId, this.name, this.children, this.icon});

  factory Children.fromJson(Map<String, dynamic> json) =>
      _$ChildrenFromJson(json);

  Map<String, dynamic> toJson() => _$ChildrenToJson(this);
}
