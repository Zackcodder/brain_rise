// models/question.dart
import 'package:hive/hive.dart';

part 'questions_model.g.dart';

@HiveType(typeId: 3)
class Question extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String lessonId;

  @HiveField(2)
  String questionText;

  @HiveField(3)
  QuestionType type;

  @HiveField(4)
  List<String> options; // For MCQ

  @HiveField(5)
  dynamic correctAnswer; // String, int, or List<String>

  @HiveField(6)
  String? explanation;

  @HiveField(7)
  String? imageUrl;

  @HiveField(8)
  int difficulty; // 1-5

  @HiveField(9)
  int timeLimit; // seconds (0 = no limit)

  @HiveField(10)
  List<String> tags; // [algebra, equations, linear]

  Question({
    required this.id,
    required this.lessonId,
    required this.questionText,
    required this.type,
    this.options = const [],
    required this.correctAnswer,
    this.explanation,
    this.imageUrl,
    this.difficulty = 1,
    this.timeLimit = 0,
    this.tags = const [],
  });
}

@HiveType(typeId: 4)
enum QuestionType {
  @HiveField(0)
  multipleChoice,

  @HiveField(1)
  trueFalse,

  @HiveField(2)
  fillInBlank,

  @HiveField(3)
  matching,

  @HiveField(4)
  multiSelect,
}
