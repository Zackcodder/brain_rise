import 'package:brain_rise/Screens/onboarding/select_subject_screen.dart';
import 'package:flutter/material.dart';

class SelectStudentCategoryScreen extends StatefulWidget {
  const SelectStudentCategoryScreen({super.key, required this.examType});

  final String examType;

  @override
  State<SelectStudentCategoryScreen> createState() =>
      _SelectStudentCategoryScreenState();
}

class _SelectStudentCategoryScreenState
    extends State<SelectStudentCategoryScreen> {
  String? selectedCategory;

  final List<Map<String, String>> categories = [
    {
      'id': 'all',
      'name': 'All Subjects',
      'description': 'Show all available subjects',
    },
    {
      'id': 'science',
      'name': 'Science Student',
      'description': 'Physics, Chemistry, Biology, Further Math',
    },
    {
      'id': 'arts',
      'name': 'Arts Student',
      'description': 'Literature, Government, History, CRS/IRS',
    },
    {
      'id': 'commerce',
      'name': 'Commerce Student',
      'description': 'Accounting, Economics, Commerce, Math',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Student Category')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What type of student are you?',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'This helps us show relevant subjects for \${widget.examType}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category['id'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () =>
                            setState(() => selectedCategory = category['id']),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1)
                                : Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    category['name']![0],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category['name']!,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                    Text(
                                      category['description']!,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedCategory == null
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SelectSubjectScreen(
                                examType: widget.examType,
                                studentCategory: selectedCategory!,
                              ),
                            ),
                          );
                        },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
