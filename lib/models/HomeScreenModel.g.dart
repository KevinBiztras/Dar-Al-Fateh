// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeScreenModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomePageDataAdapter extends TypeAdapter<HomePageData> {
  @override
  final int typeId = 1;

  @override
  HomePageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomePageData(
      addons: fields[1] as Addons?,
      homepageDataCount: fields[10] as int?,
      itemsPerPage: fields[0] as int?,
      termsAndConditions: fields[3] as bool?,
      categories: (fields[4] as List?)?.cast<Categories>(),
      defaultLanguage: (fields[2] as List?)?.cast<String>(),
      homepageDataList: (fields[9] as List?)?.cast<HomepageDataList>(),
      cartCount: fields[7] as int?,
      wishlist: (fields[12] as List?)?.cast<int>(),
      defaultPricelist: (fields[6] as List?)?.cast<String>(),
      allLanguages: (fields[5] as List?)
          ?.map((dynamic e) => (e as List).cast<String>())
          ?.toList(),
      allPricelists: (fields[8] as List?)
          ?.map((dynamic e) => (e as List).cast<String>())
          ?.toList(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?;
  }

  @override
  void write(BinaryWriter writer, HomePageData obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.itemsPerPage)
      ..writeByte(1)
      ..write(obj.addons)
      ..writeByte(2)
      ..write(obj.defaultLanguage)
      ..writeByte(3)
      ..write(obj.termsAndConditions)
      ..writeByte(4)
      ..write(obj.categories)
      ..writeByte(5)
      ..write(obj.allLanguages)
      ..writeByte(6)
      ..write(obj.defaultPricelist)
      ..writeByte(7)
      ..write(obj.cartCount)
      ..writeByte(10)
      ..write(obj.homepageDataCount)
      ..writeByte(8)
      ..write(obj.allPricelists)
      ..writeByte(9)
      ..write(obj.homepageDataList)
      ..writeByte(12)
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
      other is HomePageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HomepageDataListAdapter extends TypeAdapter<HomepageDataList> {
  @override
  final int typeId = 4;

  @override
  HomepageDataList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomepageDataList(
      name: fields[0] as String?,
      type: fields[1] as String?,
      data: (fields[2] as List?)?.cast<Data>(),
      featuredCategoryViewType: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HomepageDataList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.featuredCategoryViewType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomepageDataListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 5;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      categoryName: fields[0] as String?,
      categoryId: fields[1] as int?,
      url: fields[2] as String?,
      bannerName: fields[3] as String?,
      bannerType: fields[4] as String?,
      id: fields[5] as dynamic,
      title: fields[6] as String?,
      domain: fields[7] as String?,
      itemDisplayLimit: fields[8] as int?,
      sliderMode: fields[9] as String?,
      products: (fields[10] as List?)?.cast<Products>(),
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.bannerName)
      ..writeByte(4)
      ..write(obj.bannerType)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.domain)
      ..writeByte(8)
      ..write(obj.itemDisplayLimit)
      ..writeByte(9)
      ..write(obj.sliderMode)
      ..writeByte(10)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddonsAdapter extends TypeAdapter<Addons> {
  @override
  final int typeId = 2;

  @override
  Addons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addons(
      wishlist: fields[0] as bool?,
      review: fields[1] as bool?,
      emailVerification: fields[2] as bool?,
      odooGdpr: fields[5] as bool?,
      odooMarketplace: fields[3] as bool?,
      websiteSaleDelivery: fields[4] as bool?,
      websiteSaleStock: fields[6] as bool?,
      odooWatchApp: fields[7] as bool?,
      websiteSaleComparison: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Addons obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.wishlist)
      ..writeByte(1)
      ..write(obj.review)
      ..writeByte(2)
      ..write(obj.emailVerification)
      ..writeByte(3)
      ..write(obj.odooMarketplace)
      ..writeByte(4)
      ..write(obj.websiteSaleDelivery)
      ..writeByte(5)
      ..write(obj.odooGdpr)
      ..writeByte(6)
      ..write(obj.websiteSaleStock)
      ..writeByte(7)
      ..write(obj.odooWatchApp)
      ..writeByte(8)
      ..write(obj.websiteSaleComparison);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 3;

  @override
  Categories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categories(
      categoryId: fields[0] as int?,
      name: fields[1] as String?,
      children: (fields[2] as List?)?.cast<Categories>(),
      icon: fields[3] as String?,
      displayType: fields[4] as String?,
      colorCode: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.children)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.displayType)
      ..writeByte(6)
      ..write(obj.colorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 8;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      templateId: fields[0] as int?,
      ribbon: fields[8] as Ribbon?,
      name: fields[1] as String?,
      priceUnit: fields[2] as String?,
      priceReduce: fields[3] as String?,
      productId: fields[4] as int?,
      productCount: fields[5] as int?,
      description: fields[6] as String?,
      thumbNail: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.templateId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.priceUnit)
      ..writeByte(3)
      ..write(obj.priceReduce)
      ..writeByte(4)
      ..write(obj.productId)
      ..writeByte(5)
      ..write(obj.productCount)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.thumbNail)
      ..writeByte(8)
      ..write(obj.ribbon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RibbonAdapter extends TypeAdapter<Ribbon> {
  @override
  final int typeId = 60;

  @override
  Ribbon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ribbon(
      bgColor: fields[4] as String?,
      position: fields[2] as String?,
      ribbonMessage: fields[1] as String?,
      textColor: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Ribbon obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.ribbonMessage)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.textColor)
      ..writeByte(4)
      ..write(obj.bgColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RibbonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChildrenAdapter extends TypeAdapter<Children> {
  @override
  final int typeId = 6;

  @override
  Children read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Children(
      categoryId: fields[0] as int?,
      name: fields[1] as String?,
      children: (fields[2] as List?)?.cast<Children>(),
      icon: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Children obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.children)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildrenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageData _$HomePageDataFromJson(Map<String, dynamic> json) => HomePageData(
      addons: json['addons'] == null
          ? null
          : Addons.fromJson(json['addons'] as Map<String, dynamic>),
      homepageDataCount: (json['homepageDataCount'] as num?)?.toInt(),
      itemsPerPage: (json['itemsPerPage'] as num?)?.toInt(),
      termsAndConditions: json['TermsAndConditions'] as bool?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultLanguage: (json['defaultLanguage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      homepageDataList: (json['homepageData'] as List<dynamic>?)
              ?.map((e) => HomepageDataList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cartCount: (json['cartCount'] as num?)?.toInt(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      defaultPricelist: (json['defaultPricelist'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allLanguages: (json['allLanguages'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      allPricelists: (json['allPricelists'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?;

Map<String, dynamic> _$HomePageDataToJson(HomePageData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'itemsPerPage': instance.itemsPerPage,
      'addons': instance.addons,
      'defaultLanguage': instance.defaultLanguage,
      'TermsAndConditions': instance.termsAndConditions,
      'categories': instance.categories,
      'allLanguages': instance.allLanguages,
      'defaultPricelist': instance.defaultPricelist,
      'cartCount': instance.cartCount,
      'homepageDataCount': instance.homepageDataCount,
      'allPricelists': instance.allPricelists,
      'homepageData': instance.homepageDataList,
      'wishlist': instance.wishlist,
    };

HomepageDataList _$HomepageDataListFromJson(Map<String, dynamic> json) =>
    HomepageDataList(
      name: json['name'] as String?,
      type: json['type'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredCategoryViewType: json['featured_category_view_type'] as String?,
    );

Map<String, dynamic> _$HomepageDataListToJson(HomepageDataList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'data': instance.data,
      'featured_category_view_type': instance.featuredCategoryViewType,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      categoryName: json['categoryName'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      url: json['url'] as String?,
      bannerName: json['bannerName'] as String?,
      bannerType: json['bannerType'] as String?,
      id: json['id'],
      title: json['title'] as String?,
      domain: json['domain'] as String?,
      itemDisplayLimit: (json['item_display_limit'] as num?)?.toInt(),
      sliderMode: json['slider_mode'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
      'url': instance.url,
      'bannerName': instance.bannerName,
      'bannerType': instance.bannerType,
      'id': instance.id,
      'title': instance.title,
      'domain': instance.domain,
      'item_display_limit': instance.itemDisplayLimit,
      'slider_mode': instance.sliderMode,
      'products': instance.products,
    };

Addons _$AddonsFromJson(Map<String, dynamic> json) => Addons(
      wishlist: json['wishlist'] as bool?,
      review: json['review'] as bool?,
      emailVerification: json['email_verification'] as bool?,
      odooGdpr: json['odoo_gdpr'] as bool?,
      odooMarketplace: json['odoo_marketplace'] as bool?,
      websiteSaleDelivery: json['website_sale_delivery'] as bool?,
      websiteSaleStock: json['website_sale_stock'] as bool?,
      odooWatchApp: json['odoo_watch_app'] as bool?,
      websiteSaleComparison: json['website_sale_comparison'] as bool?,
    );

Map<String, dynamic> _$AddonsToJson(Addons instance) => <String, dynamic>{
      'wishlist': instance.wishlist,
      'review': instance.review,
      'email_verification': instance.emailVerification,
      'odoo_marketplace': instance.odooMarketplace,
      'website_sale_delivery': instance.websiteSaleDelivery,
      'odoo_gdpr': instance.odooGdpr,
      'website_sale_stock': instance.websiteSaleStock,
      'odoo_watch_app': instance.odooWatchApp,
      'website_sale_comparison': instance.websiteSaleComparison,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      categoryId: (json['category_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      icon: json['icon'] as String?,
      displayType: json['display_type'] as String? ?? '',
      colorCode: json['color_code'] as String? ?? '',
      product_count: (json['product_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'children': instance.children,
      'icon': instance.icon,
      'display_type': instance.displayType,
      'color_code': instance.colorCode,
      'product_count': instance.product_count,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      templateId: (json['templateId'] as num?)?.toInt(),
      ribbon: json['ribbon'] == null
          ? null
          : Ribbon.fromJson(json['ribbon'] as Map<String, dynamic>),
      name: json['name'] as String?,
      priceUnit: json['priceUnit'] as String?,
      priceReduce: json['priceReduce'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
      productCount: (json['productCount'] as num?)?.toInt(),
      description: json['description'] as String?,
      thumbNail: json['thumbNail'] as String?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'templateId': instance.templateId,
      'name': instance.name,
      'priceUnit': instance.priceUnit,
      'priceReduce': instance.priceReduce,
      'productId': instance.productId,
      'productCount': instance.productCount,
      'description': instance.description,
      'thumbNail': instance.thumbNail,
      'ribbon': instance.ribbon,
    };

Ribbon _$RibbonFromJson(Map<String, dynamic> json) => Ribbon(
      bgColor: json['bg_color'] as String?,
      position: json['position'] as String?,
      ribbonMessage: json['ribbon_message'] as String?,
      textColor: json['text_color'] as String?,
    );

Map<String, dynamic> _$RibbonToJson(Ribbon instance) => <String, dynamic>{
      'ribbon_message': instance.ribbonMessage,
      'position': instance.position,
      'text_color': instance.textColor,
      'bg_color': instance.bgColor,
    };

Children _$ChildrenFromJson(Map<String, dynamic> json) => Children(
      categoryId: (json['category_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$ChildrenToJson(Children instance) => <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'children': instance.children,
      'icon': instance.icon,
    };
