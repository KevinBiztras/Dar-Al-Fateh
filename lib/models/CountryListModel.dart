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

part 'CountryListModel.g.dart';

@HiveType(typeId: HiveTypeConstants.countryListModelHiveTypeId)
@JsonSerializable()
class CountryListModel extends BaseModel {
  @HiveField(0)
  List<Countries>? countries;
  CountryListModel({this.countries});
  
  factory CountryListModel.fromJson(Map<String, dynamic> json) =>
      _$CountryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryListModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.countriesModelHiveTypeId)
@JsonSerializable()
class Countries {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<States>? states;

  Countries({this.id, this.name, this.states});

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}

@HiveType(typeId: HiveTypeConstants.statesModelHiveTypeId)
@JsonSerializable()
class States {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  States({this.id, this.name});

  factory States.fromJson(Map<String, dynamic> json) =>
      _$StatesFromJson(json);

  Map<String, dynamic> toJson() => _$StatesToJson(this);
}
