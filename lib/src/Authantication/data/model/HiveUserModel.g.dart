// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveUserModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserModelAdapter extends TypeAdapter<HiveUserModel> {
  @override
  final int typeId = 0;

  @override
  HiveUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUserModel(
      uuid: fields[0] as String?,
      uniqueName: fields[1] as String?,
      userName: fields[2] as String?,
      profileImage: fields[5] as String?,
      password: fields[3] as String?,
      email: fields[4] as String?,
      phoneNumber: fields[6] as String?,
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
      birthdate: fields[9] as String?,
      following: (fields[11] as List?)?.cast<HiveFollowModel>(),
      followers: (fields[12] as List?)?.cast<HiveFollowModel>(),
      token: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.uniqueName)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.birthdate)
      ..writeByte(10)
      ..write(obj.token)
      ..writeByte(11)
      ..write(obj.following)
      ..writeByte(12)
      ..write(obj.followers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
