// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String?,
      age: fields[3] as int,
      examPreparations: (fields[4] as List).cast<ExamPreparation>(),
      totalXP: fields[5] as int,
      currentLevel: fields[6] as int,
      gems: fields[7] as int,
      hearts: fields[8] as int,
      currentStreak: fields[9] as int,
      longestStreak: fields[10] as int,
      lastActiveDate: fields[11] as DateTime?,
      createdAt: fields[12] as DateTime,
      avatarUrl: fields[13] as String,
      weeklyXP: (fields[14] as Map).cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.examPreparations)
      ..writeByte(5)
      ..write(obj.totalXP)
      ..writeByte(6)
      ..write(obj.currentLevel)
      ..writeByte(7)
      ..write(obj.gems)
      ..writeByte(8)
      ..write(obj.hearts)
      ..writeByte(9)
      ..write(obj.currentStreak)
      ..writeByte(10)
      ..write(obj.longestStreak)
      ..writeByte(11)
      ..write(obj.lastActiveDate)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.avatarUrl)
      ..writeByte(14)
      ..write(obj.weeklyXP);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
