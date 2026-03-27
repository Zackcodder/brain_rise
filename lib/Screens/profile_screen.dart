import 'package:brain_rise/Screens/onboarding/select_examtype_screen.dart';
import 'package:brain_rise/Screens/onboarding/select_subject_screen.dart';
import 'package:brain_rise/Screens/welcome_screen.dart';
import 'package:brain_rise/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.currentUser;
          if (user == null) {
            return const Center(child: Text('No user found'));
          }

          final examPreparations = userProvider.examPreparations;
          final activeExam = userProvider.activeExam;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${user.age} years old',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () =>
                            _showEditProfileDialog(context, userProvider),
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Current Exam Section
                _buildSectionTitle(context, 'Current Exam'),
                const SizedBox(height: 12),
                if (activeExam != null)
                  _buildActiveExamCard(context, activeExam.examType, () {
                    _showExamSwitchDialog(context, userProvider);
                  }),
                const SizedBox(height: 24),

                // All Exams Section
                _buildSectionTitle(
                  context,
                  'My Exams (${examPreparations.length})',
                ),
                const SizedBox(height: 12),
                ...examPreparations.map(
                  (exam) => _buildExamCard(
                    context,
                    exam.examType,
                    exam.selectedSubjects.length,
                    exam.isActive,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _navigateToAddExam(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Exam Preparation'),
                  ),
                ),
                const SizedBox(height: 32),

                // Stats Section
                _buildSectionTitle(context, 'Statistics'),
                const SizedBox(height: 12),
                _buildStatRow(context, 'Total XP', '${user.totalXP}'),
                _buildStatRow(context, 'Current Level', '${user.currentLevel}'),
                _buildStatRow(
                  context,
                  'Longest Streak',
                  '${user.longestStreak} days',
                ),
                _buildStatRow(context, 'Gems', '${user.gems}'),
                const SizedBox(height: 32),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showLogoutDialog(context, userProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildActiveExamCard(
    BuildContext context,
    String examType,
    VoidCallback onSwitch,
  ) {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  examType[0],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                    examType,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Currently active'),
                ],
              ),
            ),
            TextButton(onPressed: onSwitch, child: const Text('Switch')),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(
    BuildContext context,
    String examType,
    int subjectCount,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              examType[0],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.grey[600],
              ),
            ),
          ),
        ),
        title: Text(examType),
        subtitle: Text('$subjectCount subjects'),
        trailing: isActive
            ? Chip(
                label: const Text('Active'),
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, UserProvider userProvider) {
    final user = userProvider.currentUser;
    if (user == null) return;

    final nameController = TextEditingController(text: user.name);
    int currentAge = user.age;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Age: '),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: currentAge > 10
                        ? () => setState(() => currentAge--)
                        : null,
                  ),
                  Text('$currentAge'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: currentAge < 25
                        ? () => setState(() => currentAge++)
                        : null,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  await userProvider.updateProfile(
                    name: nameController.text.trim(),
                    age: currentAge,
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated!')),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExamSwitchDialog(BuildContext context, UserProvider userProvider) {
    final exams = userProvider.examPreparations;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Switch Exam'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: exams.map((exam) {
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: exam.isActive
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    exam.examType[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: exam.isActive ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
              ),
              title: Text(exam.examType),
              subtitle: Text('${exam.selectedSubjects.length} subjects'),
              trailing: exam.isActive
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: exam.isActive
                  ? null
                  : () async {
                      await userProvider.switchToExam(exam.examType);
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Switched to ${exam.examType}'),
                          ),
                        );
                      }
                    },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddExam(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SelectExamTypeScreen()),
    );
  }

  void _showLogoutDialog(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await userProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change Password'),
              subtitle: const Text('Placeholder - Coming soon'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Coming soon!')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'),
              subtitle: const Text('Placeholder - Coming soon'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Coming soon!')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              subtitle: const Text('Version 1.0.0'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
