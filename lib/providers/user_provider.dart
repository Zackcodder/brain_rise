// providers/user_provider.dart
import 'package:flutter/foundation.dart';
import '../models/exam_preparation_model.dart';
import '../models/user_model.dart';
import '../services/local_storage_service.dart';

class UserProvider with ChangeNotifier {
  final LocalStorageService _storageService;
  User? _currentUser;

  UserProvider(this._storageService) {
    _loadUser();
  }

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // Get currently active exam
  ExamPreparation? get activeExam => _currentUser?.activeExam;

  // Get list of all exam preparations
  List<ExamPreparation> get examPreparations =>
      _currentUser?.examPreparations ?? [];

  Future<void> _loadUser() async {
    _currentUser = await _storageService.getCurrentUser();
    notifyListeners();
  }

  Future<void> createUser({
    required String name,
    required int age,
    required String targetExam,
    required List<String> selectedSubjects,
  }) async {
    // Create the first exam preparation
    final examPrep = ExamPreparation(
      examType: targetExam,
      selectedSubjects: selectedSubjects,
      isActive: true,
      createdAt: DateTime.now(),
    );

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      age: age,
      examPreparations: [examPrep],
      createdAt: DateTime.now(),
      hearts: 5,
      gems: 0,
      totalXP: 0,
      currentLevel: 1,
    );

    await _storageService.saveUser(user);
    _currentUser = user;
    notifyListeners();
  }

  // Add a new exam preparation
  Future<void> addExamPreparation({
    required String examType,
    required List<String> selectedSubjects,
  }) async {
    if (_currentUser == null) return;

    final newExamPrep = ExamPreparation(
      examType: examType,
      selectedSubjects: selectedSubjects,
      isActive: false,
      createdAt: DateTime.now(),
    );

    _currentUser!.examPreparations.add(newExamPrep);
    await updateUser(_currentUser!);
  }

  // Switch to a different exam preparation
  Future<void> switchToExam(String examType) async {
    if (_currentUser == null) return;

    for (var prep in _currentUser!.examPreparations) {
      prep.isActive = prep.examType == examType;
    }

    await updateUser(_currentUser!);
  }

  // Update profile (name and age)
  Future<void> updateProfile({String? name, int? age}) async {
    if (_currentUser == null) return;

    if (name != null) _currentUser!.name = name;
    if (age != null) _currentUser!.age = age;

    await updateUser(_currentUser!);
  }

  // Update subjects for an exam preparation
  Future<void> updateExamSubjects(
    String examType,
    List<String> subjects,
  ) async {
    if (_currentUser == null) return;

    final index = _currentUser!.examPreparations.indexWhere(
      (e) => e.examType == examType,
    );

    if (index != -1) {
      _currentUser!.examPreparations[index].selectedSubjects = subjects;
      await updateUser(_currentUser!);
    }
  }

  Future<void> updateUser(User user) async {
    await _storageService.saveUser(user);
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storageService.deleteUser();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> updateStreak() async {
    if (_currentUser == null) return;

    final now = DateTime.now();
    final lastActive = _currentUser!.lastActiveDate;

    if (lastActive == null) {
      // First time
      _currentUser!.currentStreak = 1;
    } else {
      final difference = now.difference(lastActive).inDays;

      if (difference == 1) {
        // Consecutive day
        _currentUser!.currentStreak++;
      } else if (difference > 1) {
        // Streak broken
        _currentUser!.currentStreak = 1;
      }
      // Same day = no change
    }

    if (_currentUser!.currentStreak > _currentUser!.longestStreak) {
      _currentUser!.longestStreak = _currentUser!.currentStreak;
    }

    _currentUser!.lastActiveDate = now;
    await updateUser(_currentUser!);
  }
}
