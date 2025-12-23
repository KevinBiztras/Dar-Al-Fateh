// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompareProductModel _$CompareProductModelFromJson(Map<String, dynamic> json) =>
    CompareProductModel(
      attributeValueList: (json['attributeValueList'] as List<dynamic>?)
          ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      showSwatchOnCollection: json['showSwatchOnCollection'] as bool?,
      showTitle: json['showTitle'] as bool?,
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      productList: (json['productsList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CompareProductModelToJson(
        CompareProductModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'addons': instance.addons,
      'showSwatchOnCollection': instance.showSwatchOnCollection,
      'attributeValueList': instance.attributeValueList,
      'productsList': instance.productList,
      'showTitle': instance.showTitle,
    };

ProductTileData _$ProductTileDataFromJson(Map<String, dynamic> json) =>
    ProductTileData(
      (json['id'] as num?)?.toInt(),
      json['priceUnit'] as String?,
      json['name'] as String?,
      json['thumbNail'] as String?,
      json['priceReduce'] as String?,
      (json['productVarientCount'] as num?)?.toInt(),
      (json['templateId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductTileDataToJson(ProductTileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productVarientCount': instance.productVarientCount,
      'templateId': instance.templateId,
      'name': instance.name,
      'priceUnit': instance.priceUnit,
      'priceReduce': instance.priceReduce,
      'thumbNail': instance.thumbNail,
    };

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) =>
    AttributeValue(
      title: json['title'] as String?,
      attributeList: (json['attributeList'] as List<dynamic>?)
          ?.map((e) => AttributeList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{
      'title': instance.title,
      'attributeList': instance.attributeList,
    };

AttributeList _$AttributeListFromJson(Map<String, dynamic> json) =>
    AttributeList(
      attributeName: json['attributeName'] as String?,
      value:
          (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AttributeListToJson(AttributeList instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'value': instance.value,
    };
