import 'package:brain_rise/Screens/onboarding/splash_screen.dart';
import 'package:brain_rise/core/app_theme.dart';
import 'package:brain_rise/providers/gamify_provider.dart';
import 'package:brain_rise/providers/progress_provider.dart';
import 'package:brain_rise/providers/user_provider.dart';
import 'package:brain_rise/services/local_storage_service.dart';
import 'package:brain_rise/services/questions_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await LocalStorageService.init();

  runApp(const BrainRiseApp());
}

class BrainRiseApp extends StatelessWidget {
  const BrainRiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorageService();

    return MultiProvider(
      providers: [
        Provider.value(value: storage),
        Provider(create: (_) => QuestionService(storage)),
        ChangeNotifierProvider(create: (_) => UserProvider(storage)),

        ChangeNotifierProxyProvider<UserProvider, GamificationProvider>(
          create: (context) =>
              GamificationProvider(context.read<UserProvider>()),
          update: (context, userProvider, gamificationProvider) {
            gamificationProvider!.updateUserProvider(userProvider);
            return gamificationProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => ProgressProvider(storage, context.read()),
        ),
      ],
      child: MaterialApp(
        title: 'BrainRise',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
