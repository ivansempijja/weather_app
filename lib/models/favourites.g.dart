// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesAdapter extends TypeAdapter<Favourites> {
  @override
  final int typeId = 0;

  @override
  Favourites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourites(
      name: fields[0] as String?,
      location: fields[1] as Position?,
    );
  }

  @override
  void write(BinaryWriter writer, Favourites obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
