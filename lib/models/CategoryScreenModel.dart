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
import 'HomeScreenModel.dart';

part 'CategoryScreenModel.g.dart';

@HiveType(typeId: HiveTypeConstants.categoryScreenModelHiveTypeId)
@JsonSerializable()
class CategoryScreenModel extends BaseModel{
  @HiveField(0)
  int? itemsPerPage;
  @HiveField(1)
  Addons? addons;
  @HiveField(2)
  int? offset;
  @HiveField(3)
  int? tcount;
  @HiveField(4)
  List<Products>? products;
  @HiveField(5)
  int? WishlistCount;
  @HiveField(6)
  List<int>? wishlist;

  CategoryScreenModel(
      {
        this.itemsPerPage,
        this.addons,
        this.offset,
        this.tcount,
        this.products,
        this.WishlistCount,
        this.wishlist
      });

  factory CategoryScreenModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryScreenModelFromJson(json);
}



