import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:hive/hive.dart';
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

import 'package:json_annotation/json_annotation.dart';

part 'GooglePlaceModel.g.dart';

@HiveType(typeId: HiveTypeConstants.googlePlaceModelHiveTypeId)
@JsonSerializable()
class GooglePlaceModel{
  @HiveField(0)
  String? status;
  @HiveField(1)
  @JsonKey(name: "html_attributions")
  List? htmlAttribute;
  @HiveField(2)
  List<Results>? results;

  GooglePlaceModel({this.status, this.htmlAttribute, this.results});

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePlaceModelFromJson(json);

}

@HiveType(typeId: HiveTypeConstants.googleResultsModelHiveTypeId)
@JsonSerializable()
class Results{
  @HiveField(0)
  @JsonKey(name: "formatted_address")
  String? formattedAddress;
  @HiveField(1)
  String? icon;
  @HiveField(2)
  @JsonKey(name: "icon_background_color")
  String? iconBackgroundColor;
  @HiveField(3)
  @JsonKey(name: "icon_mask_base_uri")
  String? iconMaskBaseUri;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? reference;
  @HiveField(6)
  @JsonKey(name: "place_id")
  String? placeId;
  @HiveField(7)
  Geometry? geometry;
  @HiveField(8)
  List<Photos>? photos;

  Results({this.name, this.icon, this.formattedAddress, this.geometry, this.iconBackgroundColor, this.iconMaskBaseUri, this.photos, this.placeId,this.reference, });
  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.googleGeometryModelHiveTypeId)
@JsonSerializable()
class Geometry{
  @HiveField(0)
Location? location;
  @HiveField(1)
@JsonKey(name: "viewport")
ViewPort? viewPort;
Geometry({this.location, this.viewPort});
factory Geometry.fromJson(Map<String, dynamic> json) =>
   _$GeometryFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.googleLocationModelHiveTypeId)
@JsonSerializable()
class Location{
  @HiveField(0)
  double? lat;
  @HiveField(1)
  double? lng;
Location({this.lat,this.lng});
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.googleViewportModelHiveTypeId)
@JsonSerializable()
class ViewPort{
  @HiveField(0)
  Location? northeast;
  @HiveField(1)
  Location? southwest;

  ViewPort({this.southwest, this.northeast});
  factory ViewPort.fromJson(Map<String, dynamic> json) =>
      _$ViewPortFromJson(json);
}

@HiveType(typeId: HiveTypeConstants.googlePhotoModelHiveTypeId)
@JsonSerializable()
class Photos{
  @HiveField(0)
  @JsonKey(name: "place_id")
  String? placeId;
  @HiveField(1)
  String? reference;

  Photos({this.reference, this.placeId});
  factory Photos.fromJson(Map<String, dynamic> json) =>
      _$PhotosFromJson(json);
}