// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaceOrderModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceOrderModelAdapter extends TypeAdapter<PlaceOrderModel> {
  @override
  final int typeId = 37;

  @override
  PlaceOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceOrderModel(
      addons: fields[0] as Addons?,
      name: fields[1] as String?,
      txnMsg: fields[2] as String?,
      transactionId: fields[4] as int?,
      url: fields[3] as String?,
      cartCount: fields[5] as int?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, PlaceOrderModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.addons)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.txnMsg)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.transactionId)
      ..writeByte(5)
      ..write(obj.cartCount)
      ..writeByte(100)
      ..write(obj.success)
      ..writeByte(101)
      ..write(obj.responseCode)
      ..writeByte(102)
      ..write(obj.message)
      ..writeByte(103)
      ..write(obj.accessDenied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderModel _$PlaceOrderModelFromJson(Map<String, dynamic> json) =>
    PlaceOrderModel(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      name: json['name'] as String?,
      txnMsg: json['txn_msg'] as String?,
      transactionId: (json['transaction_id'] as num?)?.toInt(),
      url: json['url'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$PlaceOrderModelToJson(PlaceOrderModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'addons': instance.addons,
      'name': instance.name,
      'txn_msg': instance.txnMsg,
      'url': instance.url,
      'transaction_id': instance.transactionId,
      'cartCount': instance.cartCount,
    };
