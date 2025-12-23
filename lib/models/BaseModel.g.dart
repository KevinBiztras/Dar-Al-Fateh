// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseModelAdapter extends TypeAdapter<BaseModel> {
  @override
  final int typeId = 57;

  @override
  BaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseModel(
      success: fields[100] as bool?,
      responseCode: fields[101] as int?,
      message: fields[102] as String?,
      accessDenied: fields[103] as bool?,
      cartCount: fields[104] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BaseModel obj) {
    writer
      ..writeByte(5)
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
      other is BaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) => BaseModel(
      success: json['success'] as bool?,
      responseCode: (json['responseCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      accessDenied: json['accessDenied'] as bool?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
    };
