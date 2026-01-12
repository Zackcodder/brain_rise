// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonProgressAdapter extends TypeAdapter<LessonProgress> {
  @override
  final int typeId = 5;

  @override
  LessonProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonProgress(
      userId: fields[0] as String,
      lessonId: fields[1] as String,
      status: fields[2] as LessonStatus,
      attemptsCount: fields[3] as int,
      correctAnswers: fields[4] as int,
      totalQuestions: fields[5] as int,
      xpEarned: fields[6] as int,
      completedAt: fields[7] as DateTime?,
      lastAttemptedAt: fields[8] as DateTime?,
      questionResults: (fields[9] as Map?)?.cast<String, bool>(),
      weakTopics: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LessonProgress obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.lessonId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.attemptsCount)
      ..writeByte(4)
      ..write(obj.correctAnswers)
      ..writeByte(5)
      ..write(obj.totalQuestions)
      ..writeByte(6)
      ..write(obj.xpEarned)
      ..writeByte(7)
      ..write(obj.completedAt)
      ..writeByte(8)
      ..write(obj.lastAttemptedAt)
      ..writeByte(9)
      ..write(obj.questionResults)
      ..writeByte(10)
      ..write(obj.weakTopics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonStatusAdapter extends TypeAdapter<LessonStatus> {
  @override
  final int typeId = 6;

  @override
  LessonStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LessonStatus.locked;
      case 1:
        return LessonStatus.unlocked;
      case 2:
        return LessonStatus.inProgress;
      case 3:
        return LessonStatus.completed;
      default:
        return LessonStatus.locked;
    }
  }

  @override
  void write(BinaryWriter writer, LessonStatus obj) {
    switch (obj) {
      case LessonStatus.locked:
        writer.writeByte(0);
        break;
      case LessonStatus.unlocked:
        writer.writeByte(1);
        break;
      case LessonStatus.inProgress:
        writer.writeByte(2);
        break;
      case LessonStatus.completed:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
