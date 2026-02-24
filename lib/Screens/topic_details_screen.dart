import 'package:brain_rise/models/lesson_model.dart';
import 'package:brain_rise/models/questions_model.dart';
import 'package:brain_rise/models/subject_model.dart';
import 'package:brain_rise/services/local_storage_service.dart';
import 'package:brain_rise/Screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicDetailsScreen extends StatefulWidget {
  final Lesson lesson;
  final Subject subject;

  const TopicDetailsScreen({
    super.key,
    required this.lesson,
    required this.subject,
  });
  @override
  State<TopicDetailsScreen> createState() => _TopicDetailsScreenState();
}

class _TopicDetailsScreenState extends State<TopicDetailsScreen> {
  List<Question> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final storage = context.read<LocalStorageService>();
    final questions = await storage.getQuestionsByLesson(widget.lesson.id);
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title), elevation: 0),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lesson Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.lesson.title,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.lesson.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.lesson.xpReward} XP Reward',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.amber),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.diamond, color: Colors.blue, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.lesson.gemsReward} Gems',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Study Material Section
                  Text(
                    'Study Material',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Example Questions
                  if (_questions.isNotEmpty) ...[
                    Text(
                      'Example Questions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._questions
                        .take(3)
                        .map((question) => _buildExampleQuestion(question)),
                  ] else ...[
                    const Text('No example questions available yet.'),
                  ],

                  const SizedBox(height: 24),

                  // Practice Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(subject: widget.subject),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Start Practice Quiz'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildExampleQuestion(Question question) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...question.options.map(
              (option) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: option == question.correctAnswer
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: option == question.correctAnswer
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      option == question.correctAnswer
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: option == question.correctAnswer
                          ? Colors.green
                          : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          color: option == question.correctAnswer
                              ? Colors.green
                              : null,
                          fontWeight: option == question.correctAnswer
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Explanation: ${question.explanation}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
