// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpTermsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignUpTermsModelAdapter extends TypeAdapter<SignUpTermsModel> {
  @override
  final int typeId = 54;

  @override
  SignUpTermsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignUpTermsModel(
      itemsPerPage: fields[0] as int?,
      addons: fields[1] as Addons?,
      termsAndConditions: fields[2] as String?,
    )
      ..sellerTermsAndConditions = fields[3] as String?
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, SignUpTermsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.termsAndConditions)
      ..writeByte(3)
      ..write(obj.sellerTermsAndConditions)
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
      other is SignUpTermsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpTermsModel _$SignUpTermsModelFromJson(Map<String, dynamic> json) =>
    SignUpTermsModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      termsAndConditions: json['termsAndConditions'] as String?,
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..sellerTermsAndConditions = json['term_and_condition'] as String?;

Map<String, dynamic> _$SignUpTermsModelToJson(SignUpTermsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'termsAndConditions': instance.termsAndConditions,
      'term_and_condition': instance.sellerTermsAndConditions,
    };
