import 'package:brain_rise/Screens/profile_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/subject_model.dart';
import '../../services/local_storage_service.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String examType;
  const SelectSubjectScreen({super.key, required this.examType});

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  List<Subject> _subjects = [];
  Set<String> _selectedSubjects = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final storage = context.read<LocalStorageService>();
    final subjects = await storage.getSubjectsByExam(widget.examType);

    setState(() {
      _subjects = subjects;
      _isLoading = false;
    });
  }

  void _toggleSubject(String subjectId) {
    setState(() {
      if (_selectedSubjects.contains(subjectId)) {
        _selectedSubjects.remove(subjectId);
      } else {
        _selectedSubjects.add(subjectId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Subjects')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose your subjects',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select at least 3 subjects to continue',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.1,
                            ),
                        itemCount: _subjects.length,
                        itemBuilder: (context, index) {
                          final subject = _subjects[index];
                          final isSelected = _selectedSubjects.contains(
                            subject.id,
                          );

                          return InkWell(
                            onTap: () => _toggleSubject(subject.id),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color(
                                        int.parse(
                                          subject.color.replaceFirst(
                                            '#',
                                            '0xFF',
                                          ),
                                        ),
                                      ).withOpacity(0.2)
                                    : Theme.of(context).cardTheme.color,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? Color(
                                          int.parse(
                                            subject.color.replaceFirst(
                                              '#',
                                              '0xFF',
                                            ),
                                          ),
                                        )
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///subject Icon
                                  Text(
                                    subject.iconUrl,
                                    style: const TextStyle(fontSize: 40),
                                  ),

                                  ///subject Name
                                  Text(
                                    subject.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  ///number of lessons
                                  Text(
                                    '${subject.totalLessons} lessons',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),

                                  ///check icon if selected
                                  if (isSelected)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Color(
                                          int.parse(
                                            subject.color.replaceFirst(
                                              '#',
                                              '0xFF',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    ///Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedSubjects.length < 3
                            ? null
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProfileCreationScreen(
                                      examType: widget.examType,
                                      selectedSubjects: _selectedSubjects
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                        child: Text(
                          _selectedSubjects.isEmpty
                              ? 'Select subjects'
                              : 'Continue (${_selectedSubjects.length} selected)',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
