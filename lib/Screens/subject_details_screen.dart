import 'package:brain_rise/models/subject_model.dart';
import 'package:flutter/material.dart';

class SubjectDetailsScreen extends StatelessWidget {
  final Subject subject;

  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: Center(child: Text('Subject detail screen coming next!')),
    );
  }
}
