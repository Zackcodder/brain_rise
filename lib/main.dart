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

  // Initialize Hive and create storage service
  await LocalStorageService.init();
  final storage = LocalStorageService();

  runApp(BrainRiseApp(storage: storage));
}

class BrainRiseApp extends StatefulWidget {
  final LocalStorageService storage;

  const BrainRiseApp({super.key, required this.storage});

  @override
  State<BrainRiseApp> createState() => _BrainRiseAppState();
}

class _BrainRiseAppState extends State<BrainRiseApp> {
  late final LocalStorageService _storage;

  @override
  void initState() {
    super.initState();
    _storage = widget.storage;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _storage),
        Provider(create: (_) => QuestionService(_storage)),
        ChangeNotifierProvider(create: (_) => UserProvider(_storage)),
        ChangeNotifierProxyProvider<UserProvider, GamificationProvider>(
          create: (context) =>
              GamificationProvider(context.read<UserProvider>()),
          update: (context, userProvider, gamificationProvider) {
            gamificationProvider!.updateUserProvider(userProvider);
            return gamificationProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => ProgressProvider(_storage, context.read()),
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
