import 'package:brain_rise/providers/user_provider.dart';
import 'package:brain_rise/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';

import '../models/lesson_model.dart';
import '../models/lesson_progress_model.dart';

class ProgressProvider with ChangeNotifier {
  final LocalStorageService _storage;
  final UserProvider _userProvider;
  Map<String, LessonProgress> _progressMap = {};

  bool _isLoading = false;

  ProgressProvider(this._storage, this._userProvider) {
    _loadProgress();
  }

  Map get progressMap => _progressMap;
  bool get isLoading => _isLoading;

  Future _loadProgress() async {
    final user = _userProvider.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    _progressMap = await _storage.getProgressMapForUser(user.id);

    _isLoading = false;
    notifyListeners();
  }

  LessonProgress? getProgressForLesson(String lessonId) {
    return _progressMap[lessonId];
  }

  bool isLessonUnlocked(Lesson lesson) {
    // First lesson is always unlocked
    if (lesson.order == 1) return true;

    // Check if prerequisites are completed
    for (var prereqId in lesson.prerequisiteLessonIds) {
      final prereqProgress = _progressMap[prereqId];
      if (prereqProgress == null ||
          prereqProgress.status != LessonStatus.completed) {
        return false;
      }
    }

    return true;
  }

  Future updateProgress(LessonProgress progress) async {
    await _storage.saveProgress(progress);
    _progressMap[progress.lessonId] = progress;
    notifyListeners();
  }

  Future startLesson(String lessonId) async {
    final user = _userProvider.currentUser;
    if (user == null) return;

    var progress = _progressMap[lessonId];
    if (progress == null) {
      progress = LessonProgress(
        userId: user.id,
        lessonId: lessonId,
        status: LessonStatus.inProgress,
      );
    } else {
      progress.status = LessonStatus.inProgress;
    }

    progress.lastAttemptedAt = DateTime.now();
    await updateProgress(progress);
  }

  int getCompletedLessonsCount() {
    return _progressMap.values
        .where((p) => p.status == LessonStatus.completed)
        .length;
  }

  double getOverallAccuracy() {
    final completedLessons = _progressMap.values
        .where((p) => p.totalQuestions > 0)
        .toList();

    if (completedLessons.isEmpty) return 0.0;

    final totalCorrect = completedLessons.fold(
      0,
      (sum, progress) => sum + progress.correctAnswers,
    );
    final totalQuestions = completedLessons.fold(
      0,
      (sum, progress) => sum + progress.totalQuestions,
    );

    return totalQuestions > 0 ? totalCorrect / totalQuestions : 0.0;
  }

  Future<List<Lesson>> getLessonsBySubject(String subjectId) async {
    return await _storage.getLessonsBySubject(subjectId);
  }

  Map<String, LessonProgress> getProgressMapForUser(String userId) {
    return Map.from(_progressMap);
  }
}
