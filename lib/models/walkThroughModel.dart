import 'package:json_annotation/json_annotation.dart';

import 'BaseModel.dart';
import 'HomeScreenModel.dart';

part 'walkThroughModel.g.dart';

@JsonSerializable()
class WalkThroughModel extends BaseModel {
  int? itemsPerPage;
  Addons? addons;
  List<WalkThroughData>? walkThroughData;


  WalkThroughModel({this.addons, this.walkThroughData});

  factory WalkThroughModel.fromJson(Map<String, dynamic> json) =>
      _$WalkThroughModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalkThroughModelToJson(this);

}

@JsonSerializable()
class WalkThroughData {
  String? title;
  String? description;
  int? sequence;
  String? colorCode;
  String? image;


  WalkThroughData(this.title, this.description, this.sequence, this.colorCode,this.image);

  factory WalkThroughData.fromJson(Map<String, dynamic> json) =>
      _$WalkThroughDataFromJson(json);

  Map<String, dynamic> toJson() => _$WalkThroughDataToJson(this);
}


