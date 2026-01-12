// models/user.dart
import 'package:hive/hive.dart';

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
  String targetExam; // WAEC, NECO, IELTS

  @HiveField(5)
  List<String> selectedSubjects;

  @HiveField(6)
  int totalXP;

  @HiveField(7)
  int currentLevel;

  @HiveField(8)
  int gems;

  @HiveField(9)
  int hearts;

  @HiveField(10)
  int currentStreak;

  @HiveField(11)
  int longestStreak;

  @HiveField(12)
  DateTime? lastActiveDate;

  @HiveField(13)
  DateTime createdAt;

  @HiveField(14)
  String avatarUrl;

  @HiveField(15)
  Map<String, int> weeklyXP; // {Monday: 50, Tuesday: 30, ...}

  User({
    required this.id,
    required this.name,
    this.email,
    required this.age,
    required this.targetExam,
    required this.selectedSubjects,
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
}
