import 'package:brain_rise/Screens/profile_creation_screen.dart';
import 'package:brain_rise/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/subject_model.dart';
import '../../services/local_storage_service.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String examType;
  final bool isAddingNewExam;

  const SelectSubjectScreen({
    super.key,
    required this.examType,
    this.isAddingNewExam = false,
  });

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  List<Subject> _subjects = [];
  Set<String> _selectedSubjects = {};
  bool _isLoading = true;

  // Helper methods to get limits based on exam type
  int get _minSubjects {
    switch (widget.examType) {
      case 'IELTS':
        return 4; // All 4 skills required
      default:
        return AppConstants.minSubjectsDefault;
    }
  }

  int get _maxSubjects {
    switch (widget.examType) {
      case 'JAMB':
        return AppConstants.maxSubjectsJamb;
      case 'WAEC':
      case 'NECO':
        return AppConstants.maxSubjectsWaecNeco;
      case 'IELTS':
        return 4; // All 4 skills
      default:
        return AppConstants.minSubjectsDefault;
    }
  }

  String get _subjectLimitText {
    switch (widget.examType) {
      case 'JAMB':
        return 'Select exactly 3 subjects';
      case 'WAEC':
      case 'NECO':
        return 'Select 3 to 8 subjects';
      case 'IELTS':
        return 'Select all 4 English skills';
      default:
        return 'Select at least 3 subjects';
    }
  }

  bool get _canProceed {
    if (widget.examType == 'IELTS') {
      return _selectedSubjects.length == 4;
    }
    if (widget.examType == 'JAMB') {
      return _selectedSubjects.length == 3;
    }
    return _selectedSubjects.length >= _minSubjects;
  }

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final storage = context.read<LocalStorageService>();
    List<Subject> subjects;

    // For IELTS, use predefined English skills
    if (widget.examType == 'IELTS') {
      subjects = _getIeltsSubjects();
    } else {
      subjects = await storage.getSubjectsByExam(widget.examType);
    }

    setState(() {
      _subjects = subjects;
      _isLoading = false;
    });
  }

  // Create IELTS skill subjects
  List<Subject> _getIeltsSubjects() {
    return [
      Subject(
        id: 'ielts_listening',
        name: 'Listening',
        description: 'Practice listening comprehension',
        iconUrl: '👂',
        category: 'Language',
        examTypes: ['IELTS'],
        totalLessons: 10,
        color: '#4CAF50',
      ),
      Subject(
        id: 'ielts_speaking',
        name: 'Speaking',
        description: 'Practice speaking skills',
        iconUrl: '🗣️',
        category: 'Language',
        examTypes: ['IELTS'],
        totalLessons: 10,
        color: '#2196F3',
      ),
      Subject(
        id: 'ielts_reading',
        name: 'Reading',
        description: 'Improve reading comprehension',
        iconUrl: '📖',
        category: 'Language',
        examTypes: ['IELTS'],
        totalLessons: 10,
        color: '#FF9800',
      ),
      Subject(
        id: 'ielts_writing',
        name: 'Writing',
        description: 'Master writing techniques',
        iconUrl: '✍️',
        category: 'Language',
        examTypes: ['IELTS'],
        totalLessons: 10,
        color: '#9C27B0',
      ),
    ];
  }

  void _toggleSubject(String subjectId) {
    setState(() {
      if (_selectedSubjects.contains(subjectId)) {
        _selectedSubjects.remove(subjectId);
      } else {
        // Check if we've reached the max limit
        if (_selectedSubjects.length < _maxSubjects) {
          _selectedSubjects.add(subjectId);
        } else {
          // Show snackbar when max reached
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.examType == 'JAMB'
                    ? 'You can only select 3 subjects for JAMB'
                    : 'You can select up to $_maxSubjects subjects',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  String _getButtonText() {
    if (_selectedSubjects.isEmpty) {
      return 'Select subjects';
    }

    if (widget.examType == 'IELTS') {
      return _selectedSubjects.length == 4
          ? 'Continue'
          : 'Select all 4 skills (${_selectedSubjects.length}/4)';
    }

    if (widget.examType == 'JAMB') {
      return _selectedSubjects.length == 3
          ? 'Continue'
          : 'Select 3 subjects (${_selectedSubjects.length}/3)';
    }

    return 'Continue (${_selectedSubjects.length} selected)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.examType == 'IELTS'
              ? 'Select English Skills'
              : 'Select Subjects',
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.examType == 'IELTS'
                          ? 'Choose your English skills'
                          : 'Choose your subjects',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _subjectLimitText,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      subject.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                        onPressed: _canProceed
                            ? () {
                                if (widget.isAddingNewExam) {
                                  // Return result to previous screen
                                  Navigator.pop(context, {
                                    'examType': widget.examType,
                                    'selectedSubjects': _selectedSubjects
                                        .toList(),
                                  });
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProfileCreationScreen(
                                        examType: widget.examType,
                                        selectedSubjects: _selectedSubjects
                                            .toList(),
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: Text(_getButtonText()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
