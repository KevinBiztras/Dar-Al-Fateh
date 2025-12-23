// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentModelAdapter extends TypeAdapter<PaymentModel> {
  @override
  final int typeId = 28;

  @override
  PaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentModel(
      itemsPerPage: fields[0] as int?,
      addons: fields[1] as Addons?,
      customerId: fields[2] as int?,
      userId: fields[3] as int?,
      cartCount: fields[4] as int?,
      wishlistCount: fields[5] as int?,
      isEmailVerified: fields[6] as bool?,
      acquirers: (fields[7] as List?)?.cast<Acquirers>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, PaymentModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.customerId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.cartCount)
      ..writeByte(5)
      ..write(obj.wishlistCount)
      ..writeByte(6)
      ..write(obj.isEmailVerified)
      ..writeByte(7)
      ..write(obj.acquirers)
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
      other is PaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AcquirersAdapter extends TypeAdapter<Acquirers> {
  @override
  final int typeId = 29;

  @override
  Acquirers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Acquirers(
      id: fields[0] as int?,
      name: fields[1] as String?,
      thumbNail: fields[2] as String?,
      description: fields[3] as String?,
      code: fields[4] as String?,
      extraKey: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Acquirers obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumbNail)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.code)
      ..writeByte(5)
      ..write(obj.extraKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcquirersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      customerId: (json['customerId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      acquirers: (json['acquirers'] as List<dynamic>?)
          ?.map((e) => Acquirers.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'is_email_verified': instance.isEmailVerified,
      'acquirers': instance.acquirers,
    };

Acquirers _$AcquirersFromJson(Map<String, dynamic> json) => Acquirers(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      thumbNail: json['thumbNail'] as String?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      extraKey: json['extraKey'] as String?,
    );

Map<String, dynamic> _$AcquirersToJson(Acquirers instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbNail': instance.thumbNail,
      'description': instance.description,
      'code': instance.code,
      'extraKey': instance.extraKey,
    };
