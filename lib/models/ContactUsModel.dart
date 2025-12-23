import 'package:flutter_project_structure/local_database/hive_type.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ContactUsModel.g.dart';

@HiveType(typeId: HiveTypeConstants.contactUsModelHiveTypeId)
@JsonSerializable()
class ContactUsModel extends BaseModel{
  @HiveField(0)
  ContactUsAddons? addons;
  @HiveField(1)
  String? companyName;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? email;

  ContactUsModel({
    this.addons,
    this.companyName,
    this.address,
    this.phone,
    this.email,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsModelToJson(this);
}

@HiveType(typeId: HiveTypeConstants.contactUsAddOnsModelHiveTypeId)
@JsonSerializable(explicitToJson: true)
class ContactUsAddons {
  @HiveField(0)
  @JsonKey(defaultValue: false)
  final bool wishlist;
  @HiveField(1)
  @JsonKey(defaultValue: false)
  final bool review;
  @HiveField(2)
  @JsonKey(name: 'email_verification', defaultValue: false)
  final bool emailVerification;
  @HiveField(3)
  @JsonKey(name: 'odoo_marketplace', defaultValue: false)
  final bool odooMarketplace;
  @HiveField(4)
  @JsonKey(name: 'website_sale_delivery', defaultValue: false)
  final bool websiteSaleDelivery;
  @HiveField(5)
  @JsonKey(name: 'odoo_gdpr', defaultValue: false)
  final bool odooGdpr;
  @HiveField(6)
  @JsonKey(name: 'website_sale_stock', defaultValue: false)
  final bool websiteSaleStock;


  const ContactUsAddons({
    required this.wishlist,
    required this.review,
    required this.emailVerification,
    required this.odooMarketplace,
    required this.websiteSaleDelivery,
    required this.odooGdpr,
    required this.websiteSaleStock,
  });

  factory ContactUsAddons.fromJson(Map<String, dynamic> json) =>
      _$ContactUsAddonsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsAddonsToJson(this);
}
