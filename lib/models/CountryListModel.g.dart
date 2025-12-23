// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CountryListModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryListModelAdapter extends TypeAdapter<CountryListModel> {
  @override
  final int typeId = 23;

  @override
  CountryListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryListModel(
      countries: (fields[0] as List?)?.cast<Countries>(),
    )
      ..success = fields[100] as bool?
      ..responseCode = fields[101] as int?
      ..message = fields[102] as String?
      ..accessDenied = fields[103] as bool?
      ..cartCount = fields[104] as int?;
  }

  @override
  void write(BinaryWriter writer, CountryListModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.countries)
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
      other is CountryListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountriesAdapter extends TypeAdapter<Countries> {
  @override
  final int typeId = 24;

  @override
  Countries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Countries(
      id: fields[0] as int?,
      name: fields[1] as String?,
      states: (fields[2] as List?)?.cast<States>(),
    );
  }

  @override
  void write(BinaryWriter writer, Countries obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.states);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatesAdapter extends TypeAdapter<States> {
  @override
  final int typeId = 25;

  @override
  States read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return States(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, States obj) {
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
      other is StatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListModel _$CountryListModelFromJson(Map<String, dynamic> json) =>
    CountryListModel(
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Countries.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..responseCode = (json['responseCode'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..accessDenied = json['accessDenied'] as bool?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CountryListModelToJson(CountryListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseCode': instance.responseCode,
      'message': instance.message,
      'accessDenied': instance.accessDenied,
      'cartCount': instance.cartCount,
      'countries': instance.countries,
    };

Countries _$CountriesFromJson(Map<String, dynamic> json) => Countries(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => States.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'states': instance.states,
    };

States _$StatesFromJson(Map<String, dynamic> json) => States(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StatesToJson(States instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
