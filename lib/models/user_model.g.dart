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
      targetExam: fields[4] as String,
      selectedSubjects: (fields[5] as List).cast<String>(),
      totalXP: fields[6] as int,
      currentLevel: fields[7] as int,
      gems: fields[8] as int,
      hearts: fields[9] as int,
      currentStreak: fields[10] as int,
      longestStreak: fields[11] as int,
      lastActiveDate: fields[12] as DateTime?,
      createdAt: fields[13] as DateTime,
      avatarUrl: fields[14] as String,
      weeklyXP: (fields[15] as Map?)?.cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.targetExam)
      ..writeByte(5)
      ..write(obj.selectedSubjects)
      ..writeByte(6)
      ..write(obj.totalXP)
      ..writeByte(7)
      ..write(obj.currentLevel)
      ..writeByte(8)
      ..write(obj.gems)
      ..writeByte(9)
      ..write(obj.hearts)
      ..writeByte(10)
      ..write(obj.currentStreak)
      ..writeByte(11)
      ..write(obj.longestStreak)
      ..writeByte(12)
      ..write(obj.lastActiveDate)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.avatarUrl)
      ..writeByte(15)
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
