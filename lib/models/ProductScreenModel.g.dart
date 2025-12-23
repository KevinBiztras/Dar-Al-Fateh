// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductScreenModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductScreenModelAdapter extends TypeAdapter<ProductScreenModel> {
  @override
  final int typeId = 9;

  @override
  ProductScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductScreenModel(
      fields[2] as int?,
      fields[3] as String?,
      (fields[20] as List?)?.cast<Attribute>(),
      fields[15] as String?,
      fields[16] as String?,
      fields[17] as bool?,
      fields[18] as bool?,
      (fields[12] as List?)?.cast<AlternativeProducts>(),
      fields[14] as String?,
      fields[13] as String?,
      fields[5] as double?,
      fields[11] as String?,
      (fields[4] as List?)?.cast<String>(),
      fields[0] as int?,
      fields[8] as String?,
      fields[7] as String?,
      fields[10] as int?,
      fields[9] as dynamic,
      fields[19] as String?,
      fields[6] as int?,
      (fields[21] as List?)?.cast<ProductScreenModel>(),
      (fields[22] as List?)?.cast<Combinations>(),
    )
      ..addons = fields[1] as Addons?
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, ProductScreenModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.templateId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.avgRating)
      ..writeByte(6)
      ..write(obj.totalReview)
      ..writeByte(7)
      ..write(obj.priceUnit)
      ..writeByte(8)
      ..write(obj.priceReduce)
      ..writeByte(9)
      ..write(obj.productId)
      ..writeByte(10)
      ..write(obj.productCount)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.alternativeProducts)
      ..writeByte(13)
      ..write(obj.arIos)
      ..writeByte(14)
      ..write(obj.arAndroid)
      ..writeByte(15)
      ..write(obj.thumbNail)
      ..writeByte(16)
      ..write(obj.absoluteUrl)
      ..writeByte(17)
      ..write(obj.addedToWishlist)
      ..writeByte(18)
      ..write(obj.addToCart)
      ..writeByte(19)
      ..write(obj.stockDisplayMsg)
      ..writeByte(20)
      ..write(obj.attributes)
      ..writeByte(21)
      ..write(obj.variants)
      ..writeByte(22)
      ..write(obj.combinations)
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
      other is ProductScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttributeAdapter extends TypeAdapter<Attribute> {
  @override
  final int typeId = 10;

  @override
  Attribute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attribute(
      name: fields[1] as String?,
      type: fields[3] as String?,
      values: (fields[4] as List?)?.cast<Values>(),
      attributeId: fields[0] as int?,
      newVariant: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Attribute obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.attributeId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.newVariant)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ValuesAdapter extends TypeAdapter<Values> {
  @override
  final int typeId = 11;

  @override
  Values read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Values(
      newVariant: fields[3] as String?,
      name: fields[0] as String?,
      htmlCode: fields[2] as String?,
      valueId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Values obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.valueId)
      ..writeByte(2)
      ..write(obj.htmlCode)
      ..writeByte(3)
      ..write(obj.newVariant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValuesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AlternativeProductsAdapter extends TypeAdapter<AlternativeProducts> {
  @override
  final int typeId = 12;

  @override
  AlternativeProducts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlternativeProducts(
      fields[1] as String?,
      fields[2] as String?,
      fields[0] as int?,
      fields[4] as String?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlternativeProducts obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.templateId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.priceUnit)
      ..writeByte(4)
      ..write(obj.priceReduce);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlternativeProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariantsAdapter extends TypeAdapter<Variants> {
  @override
  final int typeId = 13;

  @override
  Variants read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Variants(
      productId: fields[0] as int?,
      priceReduce: fields[5] as String?,
      stockDisplayMsg: fields[10] as String?,
      priceUnit: fields[6] as String?,
      images: (fields[1] as List?)?.cast<String>(),
      arIos: fields[2] as String?,
      arAndroid: fields[3] as String?,
      addToCart: fields[9] as bool?,
      absoluteUrl: fields[4] as String?,
      addedToWishlist: fields[8] as bool?,
      combinations: (fields[7] as List?)?.cast<Combinations>(),
    );
  }

  @override
  void write(BinaryWriter writer, Variants obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.arIos)
      ..writeByte(3)
      ..write(obj.arAndroid)
      ..writeByte(4)
      ..write(obj.absoluteUrl)
      ..writeByte(5)
      ..write(obj.priceReduce)
      ..writeByte(6)
      ..write(obj.priceUnit)
      ..writeByte(7)
      ..write(obj.combinations)
      ..writeByte(8)
      ..write(obj.addedToWishlist)
      ..writeByte(9)
      ..write(obj.addToCart)
      ..writeByte(10)
      ..write(obj.stockDisplayMsg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CombinationsAdapter extends TypeAdapter<Combinations> {
  @override
  final int typeId = 14;

  @override
  Combinations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Combinations(
      valueId: fields[0] as int?,
      attributeId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Combinations obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.valueId)
      ..writeByte(1)
      ..write(obj.attributeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CombinationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductScreenModel _$ProductScreenModelFromJson(Map<String, dynamic> json) =>
    ProductScreenModel(
      (json['templateId'] as num?)?.toInt(),
      json['name'] as String?,
      (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['thumbNail'] as String?,
      json['absoluteUrl'] as String?,
      json['addedToWishlist'] as bool?,
      json['add_to_cart'] as bool?,
      (json['alternativeProducts'] as List<dynamic>?)
          ?.map((e) => AlternativeProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ar_android'] as String?,
      json['ar_ios'] as String?,
      (json['avg_rating'] as num?)?.toDouble(),
      json['description'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['itemsPerPage'] as num?)?.toInt(),
      json['priceReduce'] as String?,
      json['priceUnit'] as String?,
      (json['productCount'] as num?)?.toInt(),
      json['productId'],
      json['stock_display_msg'] as String?,
      (json['total_review'] as num?)?.toInt(),
      (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductScreenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['combinations'] as List<dynamic>?)
          ?.map((e) => Combinations.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..addons = json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>);

Map<String, dynamic> _$ProductScreenModelToJson(ProductScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'templateId': instance.templateId,
      'name': instance.name,
      'images': instance.images,
      'avg_rating': instance.avgRating,
      'total_review': instance.totalReview,
      'priceUnit': instance.priceUnit,
      'priceReduce': instance.priceReduce,
      'productId': instance.productId,
      'productCount': instance.productCount,
      'description': instance.description,
      'alternativeProducts': instance.alternativeProducts,
      'ar_ios': instance.arIos,
      'ar_android': instance.arAndroid,
      'thumbNail': instance.thumbNail,
      'absoluteUrl': instance.absoluteUrl,
      'addedToWishlist': instance.addedToWishlist,
      'add_to_cart': instance.addToCart,
      'stock_display_msg': instance.stockDisplayMsg,
      'attributes': instance.attributes,
      'variants': instance.variants,
      'combinations': instance.combinations,
    };

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      name: json['name'] as String?,
      type: json['type'] as String?,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => Values.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeId: (json['attributeId'] as num?)?.toInt(),
      newVariant: json['newVariant'] as String?,
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'attributeId': instance.attributeId,
      'name': instance.name,
      'newVariant': instance.newVariant,
      'type': instance.type,
      'values': instance.values,
    };

Values _$ValuesFromJson(Map<String, dynamic> json) => Values(
      newVariant: json['newVariant'] as String?,
      name: json['name'] as String?,
      htmlCode: json['htmlCode'] as String?,
      valueId: (json['valueId'] as num?)?.toInt(),
    )..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$ValuesToJson(Values instance) => <String, dynamic>{
      'name': instance.name,
      'valueId': instance.valueId,
      'htmlCode': instance.htmlCode,
      'newVariant': instance.newVariant,
      'isSelected': instance.isSelected,
    };

AlternativeProducts _$AlternativeProductsFromJson(Map<String, dynamic> json) =>
    AlternativeProducts(
      json['name'] as String?,
      json['image'] as String?,
      (json['templateId'] as num?)?.toInt(),
      json['priceReduce'] as String?,
      json['priceUnit'] as String?,
    );

Map<String, dynamic> _$AlternativeProductsToJson(
        AlternativeProducts instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'name': instance.name,
      'image': instance.image,
      'priceUnit': instance.priceUnit,
      'priceReduce': instance.priceReduce,
    };

Variants _$VariantsFromJson(Map<String, dynamic> json) => Variants(
      productId: (json['productId'] as num?)?.toInt(),
      priceReduce: json['priceReduce'] as String?,
      stockDisplayMsg: json['stock_display_msg'] as String?,
      priceUnit: json['priceUnit'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      arIos: json['ar_ios'] as String?,
      arAndroid: json['ar_ android'] as String?,
      addToCart: json['add_to_cart'] as bool?,
      absoluteUrl: json['absoluteUrl'] as String?,
      addedToWishlist: json['addedToWishlist'] as bool?,
      combinations: (json['combinations'] as List<dynamic>?)
          ?.map((e) => Combinations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantsToJson(Variants instance) => <String, dynamic>{
      'productId': instance.productId,
      'images': instance.images,
      'ar_ios': instance.arIos,
      'ar_ android': instance.arAndroid,
      'absoluteUrl': instance.absoluteUrl,
      'priceReduce': instance.priceReduce,
      'priceUnit': instance.priceUnit,
      'combinations': instance.combinations,
      'addedToWishlist': instance.addedToWishlist,
      'add_to_cart': instance.addToCart,
      'stock_display_msg': instance.stockDisplayMsg,
    };

Combinations _$CombinationsFromJson(Map<String, dynamic> json) => Combinations(
      valueId: (json['valueId'] as num?)?.toInt(),
      attributeId: (json['attributeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CombinationsToJson(Combinations instance) =>
    <String, dynamic>{
      'valueId': instance.valueId,
      'attributeId': instance.attributeId,
    };
