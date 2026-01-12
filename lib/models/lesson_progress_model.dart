// models/lesson_progress.dart
import 'package:hive/hive.dart';

part 'lesson_progress_model.g.dart';

@HiveType(typeId: 5)
class LessonProgress extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  String lessonId;

  @HiveField(2)
  LessonStatus status;

  @HiveField(3)
  int attemptsCount;

  @HiveField(4)
  int correctAnswers;

  @HiveField(5)
  int totalQuestions;

  @HiveField(6)
  int xpEarned;

  @HiveField(7)
  DateTime? completedAt;

  @HiveField(8)
  DateTime? lastAttemptedAt;

  @HiveField(9)
  Map<String, bool> questionResults; // {questionId: isCorrect}

  @HiveField(10)
  List<String> weakTopics; // Tags of questions user got wrong

  LessonProgress({
    required this.userId,
    required this.lessonId,
    this.status = LessonStatus.locked,
    this.attemptsCount = 0,
    this.correctAnswers = 0,
    this.totalQuestions = 0,
    this.xpEarned = 0,
    this.completedAt,
    this.lastAttemptedAt,
    Map<String, bool>? questionResults,
    List<String>? weakTopics,
  }) : questionResults = questionResults ?? {},
       weakTopics = weakTopics ?? [];

  double get accuracy =>
      totalQuestions > 0 ? correctAnswers / totalQuestions : 0.0;

  bool get isPerfect => correctAnswers == totalQuestions && totalQuestions > 0;
}

@HiveType(typeId: 6)
enum LessonStatus {
  @HiveField(0)
  locked,

  @HiveField(1)
  unlocked,

  @HiveField(2)
  inProgress,

  @HiveField(3)
  completed,
}
