// providers/user_provider.dart
import 'package:flutter/foundation.dart';
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
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      age: age,
      targetExam: targetExam,
      selectedSubjects: selectedSubjects,
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

  Future<void> updateUser(User user) async {
    await _storageService.saveUser(user);
    _currentUser = user;
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
