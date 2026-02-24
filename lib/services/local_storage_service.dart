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

  // Flag to track initialization status
  static bool _isInitialized = false;

  // Initialize Hive
  static Future init() async {
    // Prevent re-initialization
    if (_isInitialized) {
      return;
    }

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

    // Open boxes with proper typing
    if (!Hive.isBoxOpen(userBoxName)) {
      await Hive.openBox<User>(userBoxName);
    }
    if (!Hive.isBoxOpen(subjectsBoxName)) {
      await Hive.openBox<Subject>(subjectsBoxName);
    }
    if (!Hive.isBoxOpen(lessonsBoxName)) {
      await Hive.openBox<Lesson>(lessonsBoxName);
    }
    if (!Hive.isBoxOpen(questionsBoxName)) {
      await Hive.openBox<Question>(questionsBoxName);
    }
    if (!Hive.isBoxOpen(progressBoxName)) {
      await Hive.openBox<LessonProgress>(progressBoxName);
    }
    if (!Hive.isBoxOpen(achievementsBoxName)) {
      await Hive.openBox<Achievement>(achievementsBoxName);
    }
    if (!Hive.isBoxOpen(settingsBoxName)) {
      await Hive.openBox(settingsBoxName);
    }

    _isInitialized = true;
  }

  // USER OPERATIONS
  Future<User?> getCurrentUser() async {
    if (Hive.isBoxOpen(userBoxName)) {
      final box = Hive.box<User>(userBoxName);
      if (box.isEmpty) return null;
      return box.getAt(0);
    }
    await Hive.openBox<User>(userBoxName);
    final box = Hive.box<User>(userBoxName);
    if (box.isEmpty) return null;
    return box.getAt(0);
  }

  Future<void> saveUser(User user) async {
    if (Hive.isBoxOpen(userBoxName)) {
      final box = Hive.box<User>(userBoxName);
      if (box.isEmpty) {
        await box.add(user);
      } else {
        await box.putAt(0, user);
      }
    } else {
      await Hive.openBox<User>(userBoxName);
      final box = Hive.box<User>(userBoxName);
      if (box.isEmpty) {
        await box.add(user);
      } else {
        await box.putAt(0, user);
      }
    }
  }

  Future<void> deleteUser() async {
    if (Hive.isBoxOpen(userBoxName)) {
      final box = Hive.box<User>(userBoxName);
      await box.clear();
    }
  }

  // SUBJECT OPERATIONS
  Future<void> saveSubjects(List<Subject> subjects) async {
    if (Hive.isBoxOpen(subjectsBoxName)) {
      final box = Hive.box<Subject>(subjectsBoxName);
      await box.clear();
      for (var subject in subjects) {
        await box.put(subject.id, subject);
      }
    } else {
      await Hive.openBox<Subject>(subjectsBoxName);
      final box = Hive.box<Subject>(subjectsBoxName);
      await box.clear();
      for (var subject in subjects) {
        await box.put(subject.id, subject);
      }
    }
  }

  Future<List<Subject>> getAllSubjects() async {
    if (Hive.isBoxOpen(subjectsBoxName)) {
      // Box is already open with proper type, use typed accessor
      final box = Hive.box<Subject>(subjectsBoxName);
      return box.values.toList();
    }
    await Hive.openBox<Subject>(subjectsBoxName);
    final box = Hive.box<Subject>(subjectsBoxName);
    return box.values.toList();
  }

  Future<Subject?> getSubjectById(String id) async {
    if (Hive.isBoxOpen(subjectsBoxName)) {
      final box = Hive.box<Subject>(subjectsBoxName);
      return box.get(id);
    }
    await Hive.openBox<Subject>(subjectsBoxName);
    final box = Hive.box<Subject>(subjectsBoxName);
    return box.get(id);
  }

  Future<List<Subject>> getSubjectsByExam(String examType) async {
    if (Hive.isBoxOpen(subjectsBoxName)) {
      final box = Hive.box<Subject>(subjectsBoxName);
      return box.values
          .where((subject) => subject.examTypes.contains(examType))
          .toList();
    }
    await Hive.openBox<Subject>(subjectsBoxName);
    final box = Hive.box<Subject>(subjectsBoxName);
    return box.values
        .where((subject) => subject.examTypes.contains(examType))
        .toList();
  }

  // LESSON OPERATIONS
  Future<void> saveLessons(List<Lesson> lessons) async {
    if (Hive.isBoxOpen(lessonsBoxName)) {
      final box = Hive.box<Lesson>(lessonsBoxName);
      for (var lesson in lessons) {
        await box.put(lesson.id, lesson);
      }
    } else {
      await Hive.openBox<Lesson>(lessonsBoxName);
      final box = Hive.box<Lesson>(lessonsBoxName);
      for (var lesson in lessons) {
        await box.put(lesson.id, lesson);
      }
    }
  }

  Future<List<Lesson>> getLessonsBySubject(String subjectId) async {
    if (Hive.isBoxOpen(lessonsBoxName)) {
      final box = Hive.box<Lesson>(lessonsBoxName);
      return box.values
          .where((lesson) => lesson.subjectId == subjectId)
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order));
    }
    await Hive.openBox<Lesson>(lessonsBoxName);
    final box = Hive.box<Lesson>(lessonsBoxName);
    return box.values.where((lesson) => lesson.subjectId == subjectId).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  Future<Lesson?> getLessonById(String id) async {
    if (Hive.isBoxOpen(lessonsBoxName)) {
      final box = Hive.box<Lesson>(lessonsBoxName);
      return box.get(id);
    }
    await Hive.openBox<Lesson>(lessonsBoxName);
    final box = Hive.box<Lesson>(lessonsBoxName);
    return box.get(id);
  }

  // QUESTION OPERATIONS
  Future<void> saveQuestions(List<Question> questions) async {
    if (Hive.isBoxOpen(questionsBoxName)) {
      final box = Hive.box<Question>(questionsBoxName);
      for (var question in questions) {
        await box.put(question.id, question);
      }
    } else {
      await Hive.openBox<Question>(questionsBoxName);
      final box = Hive.box<Question>(questionsBoxName);
      for (var question in questions) {
        await box.put(question.id, question);
      }
    }
  }

  Future<List<Question>> getQuestionsByLesson(String lessonId) async {
    if (Hive.isBoxOpen(questionsBoxName)) {
      final box = Hive.box<Question>(questionsBoxName);
      return box.values
          .where((question) => question.lessonId == lessonId)
          .toList();
    }
    await Hive.openBox<Question>(questionsBoxName);
    final box = Hive.box<Question>(questionsBoxName);
    return box.values
        .where((question) => question.lessonId == lessonId)
        .toList();
  }

  Future<List<Question>> getQuestionsBySubject(String subjectId) async {
    if (Hive.isBoxOpen(questionsBoxName)) {
      final box = Hive.box<Question>(questionsBoxName);
      return box.values
          .where((question) => question.lessonId.startsWith(subjectId))
          .toList();
    }
    await Hive.openBox<Question>(questionsBoxName);
    final box = Hive.box<Question>(questionsBoxName);
    return box.values
        .where((question) => question.lessonId.startsWith(subjectId))
        .toList();
  }

  Future<Question?> getQuestionById(String id) async {
    if (Hive.isBoxOpen(questionsBoxName)) {
      final box = Hive.box<Question>(questionsBoxName);
      return box.get(id);
    }
    await Hive.openBox<Question>(questionsBoxName);
    final box = Hive.box<Question>(questionsBoxName);
    return box.get(id);
  }

  // PROGRESS OPERATIONS
  Future<void> saveProgress(LessonProgress progress) async {
    final key = '${progress.userId}_${progress.lessonId}';
    if (Hive.isBoxOpen(progressBoxName)) {
      final box = Hive.box<LessonProgress>(progressBoxName);
      await box.put(key, progress);
    } else {
      await Hive.openBox<LessonProgress>(progressBoxName);
      final box = Hive.box<LessonProgress>(progressBoxName);
      await box.put(key, progress);
    }
  }

  Future<LessonProgress?> getProgress(String userId, String lessonId) async {
    final key = '${userId}_$lessonId';
    if (Hive.isBoxOpen(progressBoxName)) {
      final box = Hive.box<LessonProgress>(progressBoxName);
      return box.get(key);
    }
    await Hive.openBox<LessonProgress>(progressBoxName);
    final box = Hive.box<LessonProgress>(progressBoxName);
    return box.get(key);
  }

  Future<List<LessonProgress>> getAllProgressForUser(String userId) async {
    if (Hive.isBoxOpen(progressBoxName)) {
      final box = Hive.box<LessonProgress>(progressBoxName);
      return box.values.where((progress) => progress.userId == userId).toList();
    }
    await Hive.openBox<LessonProgress>(progressBoxName);
    final box = Hive.box<LessonProgress>(progressBoxName);
    return box.values.where((progress) => progress.userId == userId).toList();
  }

  Future<Map<String, LessonProgress>> getProgressMapForUser(
    String userId,
  ) async {
    if (Hive.isBoxOpen(progressBoxName)) {
      final box = Hive.box<LessonProgress>(progressBoxName);
      final map = <String, LessonProgress>{};
      for (var progress in box.values) {
        if (progress.userId == userId) {
          map[progress.lessonId] = progress;
        }
      }
      return map;
    }
    await Hive.openBox<LessonProgress>(progressBoxName);
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
    if (Hive.isBoxOpen(achievementsBoxName)) {
      final box = Hive.box<Achievement>(achievementsBoxName);
      await box.clear();
      for (var achievement in achievements) {
        await box.put(achievement.id, achievement);
      }
    } else {
      await Hive.openBox<Achievement>(achievementsBoxName);
      final box = Hive.box<Achievement>(achievementsBoxName);
      await box.clear();
      for (var achievement in achievements) {
        await box.put(achievement.id, achievement);
      }
    }
  }

  Future<List<Achievement>> getAllAchievements() async {
    if (Hive.isBoxOpen(achievementsBoxName)) {
      final box = Hive.box<Achievement>(achievementsBoxName);
      return box.values.toList();
    }
    await Hive.openBox<Achievement>(achievementsBoxName);
    final box = Hive.box<Achievement>(achievementsBoxName);
    return box.values.toList();
  }

  Future<void> updateAchievement(Achievement achievement) async {
    if (Hive.isBoxOpen(achievementsBoxName)) {
      final box = Hive.box<Achievement>(achievementsBoxName);
      await box.put(achievement.id, achievement);
    } else {
      await Hive.openBox<Achievement>(achievementsBoxName);
      final box = Hive.box<Achievement>(achievementsBoxName);
      await box.put(achievement.id, achievement);
    }
  }

  // SETTINGS OPERATIONS
  Future<void> saveSetting(String key, dynamic value) async {
    if (Hive.isBoxOpen(settingsBoxName)) {
      final box = Hive.box(settingsBoxName);
      await box.put(key, value);
    } else {
      await Hive.openBox(settingsBoxName);
      final box = Hive.box(settingsBoxName);
      await box.put(key, value);
    }
  }

  Future<T?> getSetting<T>(String key, {T? defaultValue}) async {
    if (Hive.isBoxOpen(settingsBoxName)) {
      final box = Hive.box(settingsBoxName);
      return box.get(key, defaultValue: defaultValue) as T?;
    }
    await Hive.openBox(settingsBoxName);
    final box = Hive.box(settingsBoxName);
    return box.get(key, defaultValue: defaultValue) as T?;
  }

  // CLEAR ALL DATA (for testing/reset)
  Future<void> clearAllData() async {
    if (Hive.isBoxOpen(userBoxName)) {
      await Hive.box<User>(userBoxName).clear();
    }
    if (Hive.isBoxOpen(subjectsBoxName)) {
      await Hive.box<Subject>(subjectsBoxName).clear();
    }
    if (Hive.isBoxOpen(lessonsBoxName)) {
      await Hive.box<Lesson>(lessonsBoxName).clear();
    }
    if (Hive.isBoxOpen(questionsBoxName)) {
      await Hive.box<Question>(questionsBoxName).clear();
    }
    if (Hive.isBoxOpen(progressBoxName)) {
      await Hive.box<LessonProgress>(progressBoxName).clear();
    }
    if (Hive.isBoxOpen(achievementsBoxName)) {
      await Hive.box<Achievement>(achievementsBoxName).clear();
    }
    if (Hive.isBoxOpen(settingsBoxName)) {
      await Hive.box(settingsBoxName).clear();
    }
  }
}
