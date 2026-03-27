// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_preparation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamPreparationAdapter extends TypeAdapter<ExamPreparation> {
  @override
  final int typeId = 10;

  @override
  ExamPreparation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamPreparation(
      examType: fields[0] as String,
      selectedSubjects: (fields[1] as List).cast<String>(),
      isActive: fields[2] as bool,
      progressPerSubject: (fields[3] as Map).cast<String, double>(),
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExamPreparation obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.examType)
      ..writeByte(1)
      ..write(obj.selectedSubjects)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.progressPerSubject)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamPreparationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
