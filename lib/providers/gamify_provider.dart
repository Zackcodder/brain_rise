// providers/gamification_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'user_provider.dart';

class GamificationProvider with ChangeNotifier {
  UserProvider _userProvider;

  GamificationProvider(this._userProvider);

  User? get user => _userProvider.currentUser;
  void updateUserProvider(UserProvider userProvider) {
    _userProvider = userProvider;
  }

  // XP System
  Future<void> addXP(int amount) async {
    if (user == null) return;

    final oldLevel = user!.currentLevel;
    user!.totalXP += amount;

    // Level up logic
    while (user!.totalXP >= user!.xpForNextLevel) {
      user!.currentLevel++;
      user!.gems += 10; // Bonus gems for leveling up

      // Show level up animation (handled in UI)
    }

    // Track weekly XP
    final today = _getDayOfWeek();
    user!.weeklyXP[today] = (user!.weeklyXP[today] ?? 0) + amount;

    await _userProvider.updateUser(user!);

    if (user!.currentLevel > oldLevel) {
      // Trigger level up celebration
      notifyListeners();
    }
  }

  // Hearts System
  Future<void> loseHeart() async {
    if (user == null || user!.hearts <= 0) return;

    user!.hearts--;
    await _userProvider.updateUser(user!);
    notifyListeners();
  }

  Future<void> refillHearts() async {
    if (user == null) return;

    user!.hearts = 5;
    await _userProvider.updateUser(user!);
    notifyListeners();
  }

  bool get hasHearts => user != null && user!.hearts > 0;

  // Gems System
  Future<void> addGems(int amount) async {
    if (user == null) return;

    user!.gems += amount;
    await _userProvider.updateUser(user!);
    notifyListeners();
  }

  Future<bool> spendGems(int amount) async {
    if (user == null || user!.gems < amount) return false;

    user!.gems -= amount;
    await _userProvider.updateUser(user!);
    notifyListeners();
    return true;
  }

  String _getDayOfWeek() {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[DateTime.now().weekday - 1];
  }
}
