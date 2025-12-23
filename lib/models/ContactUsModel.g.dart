// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactUsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactUsModelAdapter extends TypeAdapter<ContactUsModel> {
  @override
  final int typeId = 55;

  @override
  ContactUsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactUsModel(
      addons: fields[0] as ContactUsAddons?,
      companyName: fields[1] as String?,
      address: fields[2] as String?,
      phone: fields[3] as String?,
      email: fields[4] as String?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, ContactUsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.addons)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(100)
      ..write(obj.success)
      ..writeByte(101)
      ..write(obj.responseCode)
      ..writeByte(102)
      ..write(obj.message)
      ..writeByte(103)
      ..write(obj.accessDenied)
      ..writeByte(104)
      ..write(obj.cartCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactUsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactUsAddonsAdapter extends TypeAdapter<ContactUsAddons> {
  @override
  final int typeId = 56;

  @override
  ContactUsAddons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactUsAddons(
      wishlist: fields[0] as bool,
      review: fields[1] as bool,
      emailVerification: fields[2] as bool,
      odooMarketplace: fields[3] as bool,
      websiteSaleDelivery: fields[4] as bool,
      odooGdpr: fields[5] as bool,
      websiteSaleStock: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ContactUsAddons obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.wishlist)
      ..writeByte(1)
      ..write(obj.review)
      ..writeByte(2)
      ..write(obj.emailVerification)
      ..writeByte(3)
      ..write(obj.odooMarketplace)
      ..writeByte(4)
      ..write(obj.websiteSaleDelivery)
      ..writeByte(5)
      ..write(obj.odooGdpr)
      ..writeByte(6)
      ..write(obj.websiteSaleStock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactUsAddonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsModel _$ContactUsModelFromJson(Map<String, dynamic> json) =>
    ContactUsModel(
      addons: json['addons'] == null
          ? null
          : ContactUsAddons.fromJson(json['addons'] as Map<String, dynamic>),
      companyName: json['companyName'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$ContactUsModelToJson(ContactUsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'addons': instance.addons,
      'companyName': instance.companyName,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
    };

ContactUsAddons _$ContactUsAddonsFromJson(Map<String, dynamic> json) =>
    ContactUsAddons(
      wishlist: json['wishlist'] as bool? ?? false,
      review: json['review'] as bool? ?? false,
      emailVerification: json['email_verification'] as bool? ?? false,
      odooMarketplace: json['odoo_marketplace'] as bool? ?? false,
      websiteSaleDelivery: json['website_sale_delivery'] as bool? ?? false,
      odooGdpr: json['odoo_gdpr'] as bool? ?? false,
      websiteSaleStock: json['website_sale_stock'] as bool? ?? false,
    );

Map<String, dynamic> _$ContactUsAddonsToJson(ContactUsAddons instance) =>
    <String, dynamic>{
      'wishlist': instance.wishlist,
      'review': instance.review,
      'email_verification': instance.emailVerification,
      'odoo_marketplace': instance.odooMarketplace,
      'website_sale_delivery': instance.websiteSaleDelivery,
      'odoo_gdpr': instance.odooGdpr,
      'website_sale_stock': instance.websiteSaleStock,
    };
