// models/subject.dart
import 'package:hive/hive.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 1)
class Subject extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String iconUrl;

  @HiveField(4)
  String category; // Science, Arts, Commercial

  @HiveField(5)
  List<String> examTypes; // [WAEC, NECO, IELTS]

  @HiveField(6)
  int totalLessons;

  @HiveField(7)
  String color; // Hex color for UI

  Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.category,
    required this.examTypes,
    required this.totalLessons,
    required this.color,
  });
}
