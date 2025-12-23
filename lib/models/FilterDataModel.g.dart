// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FilterDataModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetFilterAttributeAdapter extends TypeAdapter<GetFilterAttribute> {
  @override
  final int typeId = 63;

  @override
  GetFilterAttribute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetFilterAttribute(
      success: fields[0] as bool?,
      responseCode: fields[1] as int?,
      applied_category_id: fields[8] as int?,
      message: fields[3] as String?,
      offset: fields[2] as int?,
      itemsPerPage: fields[4] as int?,
      applied_filters: (fields[17] as List?)?.cast<AppliedFilters>(),
      addons: fields[5] as Addons?,
      is_price_filter_available: fields[14] as bool?,
      customerId: fields[6] as int?,
      isPriceFilterAvailable: fields[19] as bool?,
      userId: fields[7] as int?,
      cartCount: fields[9] as int?,
      wishlistCount: fields[10] as int?,
      categories: (fields[11] as List?)?.cast<Categories>(),
      filters: (fields[12] as List?)?.cast<Filters>(),
      wishlist: (fields[23] as List?)?.cast<int>(),
      total_product_count: fields[15] as int?,
      products: (fields[18] as List?)?.cast<Products>(),
      min_price: fields[20] as double?,
      max_price: fields[21] as double?,
      availableMinPrice: fields[22] as double?,
      availableMaxPrice: fields[13] as double?,
    )..tcount = fields[16] as int?;
  }

  @override
  void write(BinaryWriter writer, GetFilterAttribute obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.responseCode)
      ..writeByte(2)
      ..write(obj.offset)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.itemsPerPage)
      ..writeByte(5)
      ..write(obj.addons)
      ..writeByte(6)
      ..write(obj.customerId)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.applied_category_id)
      ..writeByte(9)
      ..write(obj.cartCount)
      ..writeByte(10)
      ..write(obj.wishlistCount)
      ..writeByte(11)
      ..write(obj.categories)
      ..writeByte(12)
      ..write(obj.filters)
      ..writeByte(13)
      ..write(obj.availableMaxPrice)
      ..writeByte(14)
      ..write(obj.is_price_filter_available)
      ..writeByte(15)
      ..write(obj.total_product_count)
      ..writeByte(16)
      ..write(obj.tcount)
      ..writeByte(17)
      ..write(obj.applied_filters)
      ..writeByte(18)
      ..write(obj.products)
      ..writeByte(19)
      ..write(obj.isPriceFilterAvailable)
      ..writeByte(20)
      ..write(obj.min_price)
      ..writeByte(21)
      ..write(obj.max_price)
      ..writeByte(22)
      ..write(obj.availableMinPrice)
      ..writeByte(23)
      ..write(obj.wishlist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetFilterAttributeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FiltersAdapter extends TypeAdapter<Filters> {
  @override
  final int typeId = 64;

  @override
  Filters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Filters(
      id: fields[0] as int?,
      name: fields[1] as String?,
      displayType: fields[2] as String?,
      attributeValue: (fields[3] as List?)?.cast<AttributeValue>(),
    );
  }

  @override
  void write(BinaryWriter writer, Filters obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.displayType)
      ..writeByte(3)
      ..write(obj.attributeValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FiltersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttributeValueAdapter extends TypeAdapter<AttributeValue> {
  @override
  final int typeId = 65;

  @override
  AttributeValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttributeValue(
      id: fields[0] as int?,
      name: fields[1] as String?,
      colorCode: fields[2] as String?,
      attributeValue: (fields[4] as List?)?.cast<AttributeValue>(),
      isChecked: fields[5] as bool?,
    )..product_count = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, AttributeValue obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.colorCode)
      ..writeByte(3)
      ..write(obj.product_count)
      ..writeByte(4)
      ..write(obj.attributeValue)
      ..writeByte(5)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppliedFiltersAdapter extends TypeAdapter<AppliedFilters> {
  @override
  final int typeId = 66;

  @override
  AppliedFilters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppliedFilters(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppliedFilters obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppliedFiltersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppliedFiltersValueAdapter extends TypeAdapter<AppliedFiltersValue> {
  @override
  final int typeId = 67;

  @override
  AppliedFiltersValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppliedFiltersValue(
      id: fields[0] as int?,
      name: fields[1] as String?,
      colorCode: fields[2] as String?,
      isChecked: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AppliedFiltersValue obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.colorCode)
      ..writeByte(3)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppliedFiltersValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFilterAttribute _$GetFilterAttributeFromJson(Map<String, dynamic> json) =>
    GetFilterAttribute(
      success: json['success'] as bool?,
      responseCode: (json['responseCode'] as num?)?.toInt(),
      applied_category_id: (json['applied_category_id'] as num?)?.toInt(),
      message: json['message'] as String?,
      offset: (json['offset'] as num?)?.toInt(),
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      applied_filters: (json['applied_filters'] as List<dynamic>?)
          ?.map((e) => AppliedFilters.fromJson(e as Map<String, dynamic>))
          .toList(),
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      is_price_filter_available: json['is_price_filter_available'] as bool?,
      customerId: (json['customerId'] as num?)?.toInt(),
      isPriceFilterAvailable: json['isPriceFilterAvailable'] as bool?,
      userId: (json['userId'] as num?)?.toInt(),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlistCount: (json['wishlistCount'] as num?)?.toInt(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => Filters.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      total_product_count: (json['total_product_count'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      min_price: (json['min_price'] as num?)?.toDouble(),
      max_price: (json['max_price'] as num?)?.toDouble(),
      availableMinPrice: (json['available_min_price'] as num?)?.toDouble(),
      availableMaxPrice: (json['available_max_price'] as num?)?.toDouble(),
    )..tcount = (json['tcount'] as num?)?.toInt();

Map<String, dynamic> _$GetFilterAttributeToJson(GetFilterAttribute instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'offset': instance.offset,
      'message': instance.message,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'customerId': instance.customerId,
      'userId': instance.userId,
      'applied_category_id': instance.applied_category_id,
      'cartCount': instance.cartCount,
      'wishlistCount': instance.wishlistCount,
      'categories': instance.categories,
      'filters': instance.filters,
      'available_max_price': instance.availableMaxPrice,
      'is_price_filter_available': instance.is_price_filter_available,
      'total_product_count': instance.total_product_count,
      'tcount': instance.tcount,
      'applied_filters': instance.applied_filters,
      'products': instance.products,
      'isPriceFilterAvailable': instance.isPriceFilterAvailable,
      'min_price': instance.min_price,
      'max_price': instance.max_price,
      'available_min_price': instance.availableMinPrice,
      'wishlist': instance.wishlist,
    };

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      displayType: json['display_type'] as String? ?? '',
      attributeValue: (json['attribute_value'] as List<dynamic>?)
          ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_type': instance.displayType,
      'attribute_value': instance.attributeValue,
    };

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) =>
    AttributeValue(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      colorCode: json['color_code'] as String?,
      attributeValue: (json['attributeValue'] as List<dynamic>?)
          ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      isChecked: json['isChecked'] as bool?,
    )..product_count = (json['product_count'] as num?)?.toInt() ?? 0;

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color_code': instance.colorCode,
      'product_count': instance.product_count,
      'attributeValue': instance.attributeValue,
      'isChecked': instance.isChecked,
    };

AppliedFilters _$AppliedFiltersFromJson(Map<String, dynamic> json) =>
    AppliedFilters(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      applied_filters_value: (json['applied_filters_value'] as List<dynamic>?)
          ?.map((e) => AppliedFiltersValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppliedFiltersToJson(AppliedFilters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'applied_filters_value': instance.applied_filters_value,
    };

AppliedFiltersValue _$AppliedFiltersValueFromJson(Map<String, dynamic> json) =>
    AppliedFiltersValue(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      colorCode: json['color_code'] as String?,
      isChecked: json['isChecked'] as bool?,
    );

Map<String, dynamic> _$AppliedFiltersValueToJson(
        AppliedFiltersValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color_code': instance.colorCode,
      'isChecked': instance.isChecked,
    };
