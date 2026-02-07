import 'package:brain_rise/Screens/home_screen.dart';
import 'package:brain_rise/Screens/welcome_screen.dart';
import 'package:brain_rise/providers/user_provider.dart';
import 'package:brain_rise/services/questions_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for the first frame to be painted before initializing
    // This ensures all providers are properly initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future _initialize() async {
    // Ensure we have a valid context
    if (!mounted) return;
    final questionService = context.read<QuestionService>();

    ///Load initial data if not already loaded
    final isLoaded = await questionService.isDataLoaded();
    if (!mounted) return;

    if (!isLoaded) {
      await questionService.loadInitialData();
    }

    // Wait for user provider to load
    if (!mounted) return;

    // Small delay to ensure smooth transition
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    final userProvider = context.read<UserProvider>();
    final hasUser = userProvider.isLoggedIn;

    // Navigate to appropriate screen based on login status
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => hasUser ? const HomeScreen() : const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('🧠', style: TextStyle(fontSize: 60))),
            ),
            SizedBox(height: 24),
            Text(
              'BrainRise',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Learn Smarter, Rise Higher',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            SizedBox(height: 48),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
