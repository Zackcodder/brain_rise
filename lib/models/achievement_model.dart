// models/achievement.dart
import 'package:hive/hive.dart';

part 'achievement_model.g.dart';

@HiveType(typeId: 7)
class Achievement extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String iconUrl;

  @HiveField(4)
  AchievementType type;

  @HiveField(5)
  int targetValue; // e.g., 7 for "7-day streak"

  @HiveField(6)
  int gemsReward;

  @HiveField(7)
  bool isUnlocked;

  @HiveField(8)
  DateTime? unlockedAt;

  @HiveField(9)
  int currentProgress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.type,
    required this.targetValue,
    this.gemsReward = 10,
    this.isUnlocked = false,
    this.unlockedAt,
    this.currentProgress = 0,
  });

  double get progressPercentage =>
      targetValue > 0 ? (currentProgress / targetValue).clamp(0.0, 1.0) : 0.0;
}

@HiveType(typeId: 8)
enum AchievementType {
  @HiveField(0)
  streak,

  @HiveField(1)
  questionsAnswered,

  @HiveField(2)
  lessonsCompleted,

  @HiveField(3)
  perfectScore,

  @HiveField(4)
  xpMilestone,

  @HiveField(5)
  subjectMastery,
}
