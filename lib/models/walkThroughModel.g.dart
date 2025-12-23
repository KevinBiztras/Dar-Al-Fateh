// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walkThroughModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalkThroughModel _$WalkThroughModelFromJson(Map<String, dynamic> json) =>
    WalkThroughModel(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      walkThroughData: (json['walkThroughData'] as List<dynamic>?)
          ?.map((e) => WalkThroughData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..itemsPerPage = (json['itemsPerPage'] as num?)?.toInt();

Map<String, dynamic> _$WalkThroughModelToJson(WalkThroughModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'walkThroughData': instance.walkThroughData,
    };

WalkThroughData _$WalkThroughDataFromJson(Map<String, dynamic> json) =>
    WalkThroughData(
      json['title'] as String?,
      json['description'] as String?,
      (json['sequence'] as num?)?.toInt(),
      json['colorCode'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$WalkThroughDataToJson(WalkThroughData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'sequence': instance.sequence,
      'colorCode': instance.colorCode,
      'image': instance.image,
    };
