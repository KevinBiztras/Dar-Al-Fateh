// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryScreenModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryScreenModelAdapter extends TypeAdapter<CategoryScreenModel> {
  @override
  final int typeId = 15;

  @override
  CategoryScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryScreenModel(
      itemsPerPage: fields[0] as int?,
      addons: fields[1] as Addons?,
      offset: fields[2] as int?,
      tcount: fields[3] as int?,
      products: (fields[4] as List?)?.cast<Products>(),
      WishlistCount: fields[5] as int?,
      wishlist: (fields[6] as List?)?.cast<int>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, CategoryScreenModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.offset)
      ..writeByte(3)
      ..write(obj.tcount)
      ..writeByte(4)
      ..write(obj.products)
      ..writeByte(5)
      ..write(obj.WishlistCount)
      ..writeByte(6)
      ..write(obj.wishlist)
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
      other is CategoryScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryScreenModel _$CategoryScreenModelFromJson(Map<String, dynamic> json) =>
    CategoryScreenModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      offset: (json['offset'] as num?)?.toInt(),
      tcount: (json['tcount'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      WishlistCount: (json['WishlistCount'] as num?)?.toInt(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CategoryScreenModelToJson(
        CategoryScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'offset': instance.offset,
      'tcount': instance.tcount,
      'products': instance.products,
      'WishlistCount': instance.WishlistCount,
      'wishlist': instance.wishlist,
    };
