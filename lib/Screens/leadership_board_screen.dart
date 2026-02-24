import 'package:brain_rise/models/user_model.dart';
import 'package:brain_rise/providers/progress_provider.dart';
import 'package:brain_rise/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeadershipBoardScreen extends StatefulWidget {
  const LeadershipBoardScreen({super.key});

  @override
  State<LeadershipBoardScreen> createState() => _LeadershipBoardScreenState();
}

class _LeadershipBoardScreenState extends State<LeadershipBoardScreen> {
  List<Map<String, dynamic>> _leaderboard = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    // For demo purposes, we'll create a mock leaderboard
    // In a real app, this would fetch from a server or calculate from all users
    final userProvider = context.read<UserProvider>();
    final progressProvider = context.read<ProgressProvider>();

    final currentUser = userProvider.currentUser;
    if (currentUser != null) {
      // Mock other users for demonstration
      final mockUsers = [
        {
          'user': currentUser,
          'score': currentUser.currentLevel * 100 + currentUser.gems,
          'lessonsCompleted': progressProvider.getCompletedLessonsCount(),
        },
        {
          'user': User(
            id: 'user2',
            name: 'Alice Johnson',
            email: 'alice@example.com',
            age: 18,
            targetExam: 'WAEC',
            selectedSubjects: ['math', 'english'],
            currentLevel: 8,
            totalXP: 750,
            gems: 120,
            hearts: 5,
            currentStreak: 12,
            createdAt: DateTime.now().subtract(const Duration(days: 30)),
          ),
          'score': 8 * 100 + 120,
          'lessonsCompleted': 15,
        },
        {
          'user': User(
            id: 'user3',
            name: 'Bob Smith',
            email: 'bob@example.com',
            age: 17,
            targetExam: 'NECO',
            selectedSubjects: ['physics', 'chemistry'],
            currentLevel: 6,
            totalXP: 520,
            gems: 95,
            hearts: 5,
            currentStreak: 8,
            createdAt: DateTime.now().subtract(const Duration(days: 20)),
          ),
          'score': 6 * 100 + 95,
          'lessonsCompleted': 12,
        },
        {
          'user': User(
            id: 'user4',
            name: 'Carol Davis',
            email: 'carol@example.com',
            age: 19,
            targetExam: 'IELTS',
            selectedSubjects: ['biology', 'english'],
            currentLevel: 9,
            totalXP: 890,
            gems: 150,
            hearts: 5,
            currentStreak: 15,
            createdAt: DateTime.now().subtract(const Duration(days: 45)),
          ),
          'score': 9 * 100 + 150,
          'lessonsCompleted': 18,
        },
        {
          'user': User(
            id: 'user5',
            name: 'David Wilson',
            email: 'david@example.com',
            age: 16,
            targetExam: 'WAEC',
            selectedSubjects: ['math', 'physics'],
            currentLevel: 7,
            totalXP: 680,
            gems: 110,
            hearts: 5,
            currentStreak: 10,
            createdAt: DateTime.now().subtract(const Duration(days: 25)),
          ),
          'score': 7 * 100 + 110,
          'lessonsCompleted': 14,
        },
      ];

      // Sort by score (level * 100 + gems)
      mockUsers.sort(
        (a, b) => (b['score'] as int).compareTo(a['score'] as int),
      );

      setState(() {
        _leaderboard = mockUsers;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard'), elevation: 0),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _leaderboard.isEmpty
          ? const Center(child: Text('No leaderboard data available'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _leaderboard.length,
              itemBuilder: (context, index) {
                final entry = _leaderboard[index];
                final user = entry['user'] as User;
                final isCurrentUser =
                    user.id == context.read<UserProvider>().currentUser?.id;

                return _buildLeaderboardItem(
                  rank: index + 1,
                  user: user,
                  score: entry['score'],
                  lessonsCompleted: entry['lessonsCompleted'],
                  isCurrentUser: isCurrentUser,
                );
              },
            ),
    );
  }

  Widget _buildLeaderboardItem({
    required int rank,
    required User user,
    required int score,
    required int lessonsCompleted,
    required bool isCurrentUser,
  }) {
    Color rankColor;
    if (rank == 1) {
      rankColor = Colors.amber;
    } else if (rank == 2) {
      rankColor = Colors.grey;
    } else if (rank == 3) {
      rankColor = Colors.brown;
    } else {
      rankColor = Colors.grey[400]!;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isCurrentUser ? 4 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isCurrentUser
          ? Theme.of(context).primaryColor.withOpacity(0.1)
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: rankColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: rankColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isCurrentUser
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        'Level ${user.currentLevel}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.book, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        '$lessonsCompleted lessons',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Score
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$score',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  'points',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
