// models/exam_preparation_model.dart
import 'package:hive/hive.dart';

part 'exam_preparation_model.g.dart';

@HiveType(typeId: 10)
class ExamPreparation extends HiveObject {
  @HiveField(0)
  String examType; // WAEC, NECO, JAMB, IELTS

  @HiveField(1)
  List<String> selectedSubjects;

  @HiveField(2)
  bool isActive; // Currently selected exam

  @HiveField(3)
  Map<String, double> progressPerSubject; // {subjectId: progressPercentage}

  @HiveField(4)
  DateTime createdAt;

  ExamPreparation({
    required this.examType,
    required this.selectedSubjects,
    this.isActive = false,
    Map<String, double>? progressPerSubject,
    required this.createdAt,
  }) : progressPerSubject = progressPerSubject ?? {};

  // Helper methods
  double get overallProgress {
    if (progressPerSubject.isEmpty) return 0.0;
    return progressPerSubject.values.reduce((a, b) => a + b) /
        progressPerSubject.length;
  }

  int get totalSubjects => selectedSubjects.length;
}
