// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GooglePlaceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GooglePlaceModelAdapter extends TypeAdapter<GooglePlaceModel> {
  @override
  final int typeId = 48;

  @override
  GooglePlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GooglePlaceModel(
      status: fields[0] as String?,
      htmlAttribute: (fields[1] as List?)?.cast<dynamic>(),
      results: (fields[2] as List?)?.cast<Results>(),
    );
  }

  @override
  void write(BinaryWriter writer, GooglePlaceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.htmlAttribute)
      ..writeByte(2)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GooglePlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultsAdapter extends TypeAdapter<Results> {
  @override
  final int typeId = 49;

  @override
  Results read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Results(
      name: fields[4] as String?,
      icon: fields[1] as String?,
      formattedAddress: fields[0] as String?,
      geometry: fields[7] as Geometry?,
      iconBackgroundColor: fields[2] as String?,
      iconMaskBaseUri: fields[3] as String?,
      photos: (fields[8] as List?)?.cast<Photos>(),
      placeId: fields[6] as String?,
      reference: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Results obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.formattedAddress)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.iconBackgroundColor)
      ..writeByte(3)
      ..write(obj.iconMaskBaseUri)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.reference)
      ..writeByte(6)
      ..write(obj.placeId)
      ..writeByte(7)
      ..write(obj.geometry)
      ..writeByte(8)
      ..write(obj.photos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GeometryAdapter extends TypeAdapter<Geometry> {
  @override
  final int typeId = 50;

  @override
  Geometry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Geometry(
      location: fields[0] as Location?,
      viewPort: fields[1] as ViewPort?,
    );
  }

  @override
  void write(BinaryWriter writer, Geometry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.viewPort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeometryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 51;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      lat: fields[0] as double?,
      lng: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ViewPortAdapter extends TypeAdapter<ViewPort> {
  @override
  final int typeId = 52;

  @override
  ViewPort read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViewPort(
      southwest: fields[1] as Location?,
      northeast: fields[0] as Location?,
    );
  }

  @override
  void write(BinaryWriter writer, ViewPort obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.northeast)
      ..writeByte(1)
      ..write(obj.southwest);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewPortAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhotosAdapter extends TypeAdapter<Photos> {
  @override
  final int typeId = 53;

  @override
  Photos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Photos(
      reference: fields[1] as String?,
      placeId: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Photos obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.placeId)
      ..writeByte(1)
      ..write(obj.reference);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePlaceModel _$GooglePlaceModelFromJson(Map<String, dynamic> json) =>
    GooglePlaceModel(
      status: json['status'] as String?,
      htmlAttribute: json['html_attributions'] as List<dynamic>?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GooglePlaceModelToJson(GooglePlaceModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'html_attributions': instance.htmlAttribute,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      formattedAddress: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      iconBackgroundColor: json['icon_background_color'] as String?,
      iconMaskBaseUri: json['icon_mask_base_uri'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photos.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'formatted_address': instance.formattedAddress,
      'icon': instance.icon,
      'icon_background_color': instance.iconBackgroundColor,
      'icon_mask_base_uri': instance.iconMaskBaseUri,
      'name': instance.name,
      'reference': instance.reference,
      'place_id': instance.placeId,
      'geometry': instance.geometry,
      'photos': instance.photos,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      viewPort: json['viewport'] == null
          ? null
          : ViewPort.fromJson(json['viewport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
      'viewport': instance.viewPort,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

ViewPort _$ViewPortFromJson(Map<String, dynamic> json) => ViewPort(
      southwest: json['southwest'] == null
          ? null
          : Location.fromJson(json['southwest'] as Map<String, dynamic>),
      northeast: json['northeast'] == null
          ? null
          : Location.fromJson(json['northeast'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewPortToJson(ViewPort instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

Photos _$PhotosFromJson(Map<String, dynamic> json) => Photos(
      reference: json['reference'] as String?,
      placeId: json['place_id'] as String?,
    );

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'place_id': instance.placeId,
      'reference': instance.reference,
    };
