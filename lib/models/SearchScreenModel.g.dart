// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchScreenModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchScreenModelAdapter extends TypeAdapter<SearchScreenModel> {
  @override
  final int typeId = 47;

  @override
  SearchScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchScreenModel(
      isEmailVerified: fields[6] as bool?,
      customerId: fields[2] as int?,
      itemsPerPage: fields[0] as int?,
      wishlistCount: fields[5] as int?,
      sellerState: fields[9] as String?,
      sellerGroup: fields[8] as String?,
      isSeller: fields[7] as bool?,
      cartCount: fields[4] as int?,
      addons: fields[1] as Addons?,
      userId: fields[3] as int?,
      offset: fields[11] as int?,
      tcount: fields[10] as int?,
      products: (fields[12] as List?)?.cast<Products>(),
      wishlist: (fields[13] as List?)?.cast<int>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, SearchScreenModel obj) {
    writer
      ..writeByte(18)
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
      ..write(obj.tcount)
      ..writeByte(11)
      ..write(obj.offset)
      ..writeByte(12)
      ..write(obj.products)
      ..writeByte(13)
      ..write(obj.wishlist)
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
      other is SearchScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchScreenModel _$SearchScreenModelFromJson(Map<String, dynamic> json) =>
    SearchScreenModel(
      isEmailVerified: json['is_email_verified'] as bool?,
      customerId: (json['customerId'] as num?)?.toInt(),
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      sellerState: json['seller_state'] as String?,
      sellerGroup: json['seller_group'] as String?,
      isSeller: json['is_seller'] as bool?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      userId: (json['userId'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      tcount: (json['tcount'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$SearchScreenModelToJson(SearchScreenModel instance) =>
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
      'tcount': instance.tcount,
      'offset': instance.offset,
      'products': instance.products,
      'wishlist': instance.wishlist,
    };
