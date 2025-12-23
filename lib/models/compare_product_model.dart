
import 'package:json_annotation/json_annotation.dart';

import 'BaseModel.dart';
import 'HomeScreenModel.dart';
part 'compare_product_model.g.dart';

@JsonSerializable()
class CompareProductModel extends BaseModel{
  Addons ? addons;
  @JsonKey(name:"showSwatchOnCollection")
  bool? showSwatchOnCollection;
  @JsonKey(name:"attributeValueList")
  List<AttributeValue>? attributeValueList;
  @JsonKey(name:"productsList")
  List<ProductTileData>? productList;
  bool ? showTitle;

  CompareProductModel({this.attributeValueList, this.showSwatchOnCollection,this.showTitle,this.addons,this.productList});

  factory CompareProductModel.fromJson(Map<String, dynamic> json) => _$CompareProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompareProductModelToJson(this);

}
@JsonSerializable()
class ProductTileData{
  int? id;
  int? productVarientCount;
  int? templateId;
  String? name;
  String? priceUnit;
  String? priceReduce;
  String? thumbNail;

  ProductTileData(
   this.id,
  this.priceUnit,
      this.name,
      this.thumbNail,
 this.priceReduce,
      this.productVarientCount,
      this.templateId
      );

  factory ProductTileData.fromJson(Map<String, dynamic> json) =>
      _$ProductTileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTileDataToJson(this);

}

@JsonSerializable()
class AttributeValue{
  String? title;
  List<AttributeList>? attributeList;
  AttributeValue({this.title, this.attributeList});

  factory AttributeValue.fromJson(Map<String, dynamic> json) => _$AttributeValueFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeValueToJson(this);
}
@JsonSerializable()

class AttributeList {
  @JsonKey(name: "attributeName")
  String? attributeName;
  @JsonKey(name:"value")
  List<String>? value;
  AttributeList({this.attributeName, this.value});

  factory AttributeList.fromJson(Map<String, dynamic> json) => _$AttributeListFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeListToJson(this);
}