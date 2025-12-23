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
part 'PlaceOrderModel.g.dart';

@HiveType(typeId: HiveTypeConstants.placeOrderModelHiveTypeId)
@JsonSerializable()
class PlaceOrderModel extends BaseModel{
  @HiveField(0)
  Addons? addons;
  @HiveField(1)
  String? name;
  @HiveField(2)
  @JsonKey(name: 'txn_msg')
  String? txnMsg;
  @HiveField(3)
  String? url;
  @HiveField(4)
  @JsonKey(name: 'transaction_id')
  int? transactionId;
  @HiveField(5)
  int? cartCount;

  PlaceOrderModel({this.addons,this.name,this.txnMsg, this.transactionId, this.url, this.cartCount});

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderModelFromJson(json);
}