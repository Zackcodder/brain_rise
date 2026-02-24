import 'package:brain_rise/Screens/home_screen.dart';
import 'package:brain_rise/Screens/leadership_board_screen.dart';
import 'package:brain_rise/models/subject_model.dart';
import 'package:flutter/material.dart';

class QuizResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Subject subject;

  const QuizResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.subject,
  });

  double get percentage => (score / totalQuestions) * 100;

  String get grade {
    if (percentage >= 90) return 'A';
    if (percentage >= 80) return 'B';
    if (percentage >= 70) return 'C';
    if (percentage >= 60) return 'D';
    return 'F';
  }

  Color get gradeColor {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.amber;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Score Circle
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gradeColor.withOpacity(0.1),
                border: Border.all(color: gradeColor, width: 4),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score/$totalQuestions',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: gradeColor,
                          ),
                    ),
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: gradeColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Grade
            Text(
              'Grade: $grade',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: gradeColor,
              ),
            ),
            const SizedBox(height: 16),

            // Subject
            Text(subject.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),

            // Message
            Text(
              _getMessage(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Home'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const LeadershipBoardScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Leaderboard'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage() {
    if (percentage >= 90) {
      return 'Excellent work! You\'ve mastered this topic!';
    } else if (percentage >= 80) {
      return 'Great job! You\'re doing very well!';
    } else if (percentage >= 70) {
      return 'Good effort! Keep practicing to improve!';
    } else if (percentage >= 60) {
      return 'Not bad! Review the material and try again!';
    } else {
      return 'Keep studying! You can do better next time!';
    }
  }
}
