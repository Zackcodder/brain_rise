// models/lesson.dart
import 'package:hive/hive.dart';

part 'lesson_model.g.dart';

@HiveType(typeId: 2)
class Lesson extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String subjectId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;

  @HiveField(4)
  int order; // Sequence in skill tree

  @HiveField(5)
  int difficulty; // 1-5

  @HiveField(6)
  List<String> questionIds;

  @HiveField(7)
  int xpReward;

  @HiveField(8)
  int gemsReward;

  @HiveField(9)
  List<String> prerequisiteLessonIds; // Must complete these first

  @HiveField(10)
  String? videoUrl; // Optional explanation video

  @HiveField(11)
  String? readingMaterial; // Brief text content

  Lesson({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.order,
    required this.difficulty,
    required this.questionIds,
    this.xpReward = 10,
    this.gemsReward = 5,
    this.prerequisiteLessonIds = const [],
    this.videoUrl,
    this.readingMaterial,
  });
}
