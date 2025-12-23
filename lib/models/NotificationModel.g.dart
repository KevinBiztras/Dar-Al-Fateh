// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 45;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      userId: fields[3] as int?,
      addons: fields[1] as Addons?,
      cartCount: fields[4] as int?,
      isEmailVerified: fields[6] as bool?,
      isSeller: fields[7] as bool?,
      sellerGroup: fields[8] as String?,
      sellerState: fields[9] as String?,
      wishlistCount: fields[5] as int?,
      itemsPerPage: fields[0] as int?,
      customerId: fields[2] as int?,
      notificationList: (fields[10] as List?)?.cast<NotificationList>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.isSeller)
      ..writeByte(8)
      ..write(obj.sellerGroup)
      ..writeByte(9)
      ..write(obj.sellerState)
      ..writeByte(10)
      ..write(obj.notificationList)
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
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationListAdapter extends TypeAdapter<NotificationList> {
  @override
  final int typeId = 46;

  @override
  NotificationList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationList(
      body: fields[4] as String?,
      name: fields[1] as String?,
      id: fields[0] as int?,
      icon: fields[6] as String?,
      title: fields[2] as String?,
      banner: fields[5] as String?,
      dataType: fields[8] as String?,
      isRead: fields[9] as bool?,
      period: fields[7] as String?,
      subtitle: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationList obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.subtitle)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.banner)
      ..writeByte(6)
      ..write(obj.icon)
      ..writeByte(7)
      ..write(obj.period)
      ..writeByte(8)
      ..write(obj.dataType)
      ..writeByte(9)
      ..write(obj.isRead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      userId: (json['userId'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      isEmailVerified: json['is_email_verified'] as bool?,
      isSeller: json['is_seller'] as bool?,
      sellerGroup: json['seller_group'] as String?,
      sellerState: json['seller_state'] as String?,
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
      notificationList: (json['all_notification_messages'] as List<dynamic>?)
          ?.map((e) => NotificationList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
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
      'is_seller': instance.isSeller,
      'seller_group': instance.sellerGroup,
      'seller_state': instance.sellerState,
      'all_notification_messages': instance.notificationList,
    };

NotificationList _$NotificationListFromJson(Map<String, dynamic> json) =>
    NotificationList(
      body: json['body'] as String?,
      name: json['name'] as String?,
      id: (json['id'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      title: json['title'] as String?,
      banner: json['banner'] as String?,
      dataType: json['datatype'] as String?,
      isRead: json['is_reade'] as bool?,
      period: json['period'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$NotificationListToJson(NotificationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'body': instance.body,
      'banner': instance.banner,
      'icon': instance.icon,
      'period': instance.period,
      'datatype': instance.dataType,
      'is_reade': instance.isRead,
    };
