import 'package:brain_rise/models/questions_model.dart';
import 'package:brain_rise/models/subject_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/achievement_model.dart';
import '../models/lesson_model.dart';
import '../models/lesson_progress_model.dart';
import '../models/user_model.dart';

class LocalStorageService {
  // Box names
  static const String userBoxName = 'userBox';
  static const String subjectsBoxName = 'subjectsBox';
  static const String lessonsBoxName = 'lessonsBox';
  static const String questionsBoxName = 'questionsBox';
  static const String progressBoxName = 'progressBox';
  static const String achievementsBoxName = 'achievementsBox';
  static const String settingsBoxName = 'settingsBox';

  // Initialize Hive
  static Future init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(QuestionTypeAdapter());
    Hive.registerAdapter(LessonProgressAdapter());
    Hive.registerAdapter(LessonStatusAdapter());
    Hive.registerAdapter(AchievementAdapter());
    Hive.registerAdapter(AchievementTypeAdapter());

    // Open boxes
    await Hive.openBox(userBoxName);
    await Hive.openBox(subjectsBoxName);
    await Hive.openBox(lessonsBoxName);
    await Hive.openBox(questionsBoxName);
    await Hive.openBox(progressBoxName);
    await Hive.openBox(achievementsBoxName);
    await Hive.openBox(settingsBoxName);
  }

  // USER OPERATIONS
  Future<User?> getCurrentUser() async {
    final box = Hive.box<User>(userBoxName);
    if (box.isEmpty) return null;
    return box.getAt(0);
  }

  Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    if (box.isEmpty) {
      await box.add(user);
    } else {
      await box.putAt(0, user);
    }
  }

  Future<void> deleteUser() async {
    final box = Hive.box<User>(userBoxName);
    await box.clear();
  }

  // SUBJECT OPERATIONS
  Future<void> saveSubjects(List<Subject> subjects) async {
    final box = Hive.box<Subject>(subjectsBoxName);
    await box.clear();
    for (var subject in subjects) {
      await box.put(subject.id, subject);
    }
  }

  Future<List<Subject>> getAllSubjects() async {
    final box = Hive.box<Subject>(subjectsBoxName);
    return box.values.toList();
  }

  Future<Subject?> getSubjectById(String id) async {
    final box = Hive.box<Subject>(subjectsBoxName);
    return box.get(id);
  }

  Future<List<Subject>> getSubjectsByExam(String examType) async {
    final box = Hive.box<Subject>(subjectsBoxName);
    return box.values
        .where((subject) => subject.examTypes.contains(examType))
        .toList();
  }

  // LESSON OPERATIONS
  Future<void> saveLessons(List<Lesson> lessons) async {
    final box = Hive.box<Lesson>(lessonsBoxName);
    for (var lesson in lessons) {
      await box.put(lesson.id, lesson);
    }
  }

  Future<List<Lesson>> getLessonsBySubject(String subjectId) async {
    final box = Hive.box<Lesson>(lessonsBoxName);
    return box.values.where((lesson) => lesson.subjectId == subjectId).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  Future<Lesson?> getLessonById(String id) async {
    final box = Hive.box<Lesson>(lessonsBoxName);
    return box.get(id);
  }

  Future<void> saveQuestions(List<Question> questions) async {
    final box = Hive.box<Question>(questionsBoxName);
    for (var question in questions) {
      await box.put(question.id, question);
    }
  }

  Future<List<Question>> getQuestionsByLesson(String lessonId) async {
    final box = Hive.box<Question>(questionsBoxName);
    return box.values
        .where((question) => question.lessonId == lessonId)
        .toList();
  }

  Future<Question?> getQuestionById(String id) async {
    final box = Hive.box<Question>(questionsBoxName);
    return box.get(id);
  }

  // PROGRESS OPERATIONS
  Future<void> saveProgress(LessonProgress progress) async {
    final box = Hive.box<LessonProgress>(progressBoxName);
    final key = '${progress.userId}_${progress.lessonId}';
    await box.put(key, progress);
  }

  Future<LessonProgress?> getProgress(String userId, String lessonId) async {
    final box = Hive.box<LessonProgress>(progressBoxName);
    final key = '${userId}_$lessonId';
    return box.get(key);
  }

  Future<List<LessonProgress>> getAllProgressForUser(String userId) async {
    final box = Hive.box<LessonProgress>(progressBoxName);
    return box.values.where((progress) => progress.userId == userId).toList();
  }

  Future<Map<String, LessonProgress>> getProgressMapForUser(
    String userId,
  ) async {
    final box = Hive.box<LessonProgress>(progressBoxName);
    final map = <String, LessonProgress>{};
    for (var progress in box.values) {
      if (progress.userId == userId) {
        map[progress.lessonId] = progress;
      }
    }
    return map;
  }

  // ACHIEVEMENT OPERATIONS
  Future<void> saveAchievements(List<Achievement> achievements) async {
    final box = Hive.box<Achievement>(achievementsBoxName);
    await box.clear();
    for (var achievement in achievements) {
      await box.put(achievement.id, achievement);
    }
  }

  Future<List<Achievement>> getAllAchievements() async {
    final box = Hive.box<Achievement>(achievementsBoxName);
    return box.values.toList();
  }

  Future<void> updateAchievement(Achievement achievement) async {
    final box = Hive.box<Achievement>(achievementsBoxName);
    await box.put(achievement.id, achievement);
  }

  // SETTINGS OPERATIONS
  Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(settingsBoxName);
    await box.put(key, value);
  }

  Future<T?> getSetting<T>(String key, {T? defaultValue}) async {
    final box = Hive.box(settingsBoxName);
    return box.get(key, defaultValue: defaultValue) as T?;
  }

  // CLEAR ALL DATA (for testing/reset)
  Future<void> clearAllData() async {
    await Hive.box<User>(userBoxName).clear();
    await Hive.box<Subject>(subjectsBoxName).clear();
    await Hive.box<Lesson>(lessonsBoxName).clear();
    await Hive.box<Question>(questionsBoxName).clear();
    await Hive.box<LessonProgress>(progressBoxName).clear();
    await Hive.box<Achievement>(achievementsBoxName).clear();
    await Hive.box(settingsBoxName).clear();
  }
}
