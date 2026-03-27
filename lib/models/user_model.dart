// models/user.dart
import 'package:hive/hive.dart';

import 'exam_preparation_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  int age;

  @HiveField(4)
  List<ExamPreparation> examPreparations;

  @HiveField(5)
  int totalXP;

  @HiveField(6)
  int currentLevel;

  @HiveField(7)
  int gems;

  @HiveField(8)
  int hearts;

  @HiveField(9)
  int currentStreak;

  @HiveField(10)
  int longestStreak;

  @HiveField(11)
  DateTime? lastActiveDate;

  @HiveField(12)
  DateTime createdAt;

  @HiveField(13)
  String avatarUrl;

  @HiveField(14)
  Map<String, int> weeklyXP; // {Monday: 50, Tuesday: 30, ...}

  User({
    required this.id,
    required this.name,
    this.email,
    required this.age,
    required this.examPreparations,
    this.totalXP = 0,
    this.currentLevel = 1,
    this.gems = 0,
    this.hearts = 5,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActiveDate,
    required this.createdAt,
    this.avatarUrl = '',
    Map<String, int>? weeklyXP,
  }) : weeklyXP = weeklyXP ?? {};

  // Helper methods
  int get xpForNextLevel => currentLevel * 100;
  double get progressToNextLevel => totalXP % 100 / 100;

  // Get currently active exam preparation
  ExamPreparation? get activeExam {
    try {
      return examPreparations.firstWhere((e) => e.isActive);
    } catch (_) {
      return examPreparations.isNotEmpty ? examPreparations.first : null;
    }
  }

  // Get current target exam (for backwards compatibility)
  String get targetExam => activeExam?.examType ?? '';

  // Get current selected subjects (for backwards compatibility)
  List<String> get selectedSubjects => activeExam?.selectedSubjects ?? [];
}
