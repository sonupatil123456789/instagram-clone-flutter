// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveFollowModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFollowModelAdapter extends TypeAdapter<HiveFollowModel> {
  @override
  final int typeId = 1;

  @override
  HiveFollowModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFollowModel(
      uuid: fields[0] as String?,
      uniqueName: fields[1] as String?,
      profileImage: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFollowModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.uniqueName)
      ..writeByte(2)
      ..write(obj.profileImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFollowModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
