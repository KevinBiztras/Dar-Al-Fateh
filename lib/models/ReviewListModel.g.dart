// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewListModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewListModelAdapter extends TypeAdapter<ReviewListModel> {
  @override
  final int typeId = 16;

  @override
  ReviewListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewListModel(
      itemsPerPage: fields[0] as int?,
      productReviews: (fields[1] as List?)?.cast<ProductReviews>(),
      reviewCount: fields[2] as int?,
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, ReviewListModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.productReviews)
      ..writeByte(2)
      ..write(obj.reviewCount)
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
      other is ReviewListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductReviewsAdapter extends TypeAdapter<ProductReviews> {
  @override
  final int typeId = 17;

  @override
  ProductReviews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductReviews(
      id: fields[0] as int?,
      customer: fields[1] as String?,
      customerImage: fields[2] as String?,
      email: fields[3] as String?,
      likes: fields[4] as int?,
      dislikes: fields[5] as int?,
      rating: fields[6] as double?,
      title: fields[7] as String?,
      msg: fields[8] as String?,
      createDate: fields[9] as String?,
      writeDate: fields[10] as String?,
      isEmailVerified: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductReviews obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customer)
      ..writeByte(2)
      ..write(obj.customerImage)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.likes)
      ..writeByte(5)
      ..write(obj.dislikes)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.msg)
      ..writeByte(9)
      ..write(obj.createDate)
      ..writeByte(10)
      ..write(obj.writeDate)
      ..writeByte(11)
      ..write(obj.isEmailVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductReviewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewListModel _$ReviewListModelFromJson(Map<String, dynamic> json) =>
    ReviewListModel(
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      productReviews: (json['product_reviews'] as List<dynamic>?)
          ?.map((e) => ProductReviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$ReviewListModelToJson(ReviewListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'itemsPerPage': instance.itemsPerPage,
      'product_reviews': instance.productReviews,
      'reviewCount': instance.reviewCount,
    };

ProductReviews _$ProductReviewsFromJson(Map<String, dynamic> json) =>
    ProductReviews(
      id: (json['id'] as num?)?.toInt(),
      customer: json['customer'] as String?,
      customerImage: json['customer_image'] as String?,
      email: json['email'] as String?,
      likes: (json['likes'] as num?)?.toInt(),
      dislikes: (json['dislikes'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      title: json['title'] as String?,
      msg: json['msg'] as String?,
      createDate: json['create_date'] as String?,
      writeDate: json['write_date'] as String?,
      isEmailVerified: json['is_email_verified'] as bool?,
    );

Map<String, dynamic> _$ProductReviewsToJson(ProductReviews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'customer_image': instance.customerImage,
      'email': instance.email,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'rating': instance.rating,
      'title': instance.title,
      'msg': instance.msg,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
      'is_email_verified': instance.isEmailVerified,
    };
