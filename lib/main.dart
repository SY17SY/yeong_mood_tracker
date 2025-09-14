import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeong_mood_tracker/constants/sizes.dart';
import 'package:yeong_mood_tracker/firebase_options.dart';
import 'package:yeong_mood_tracker/repos/settings_repo.dart';
import 'package:yeong_mood_tracker/router.dart';
import 'package:yeong_mood_tracker/view_models/settings_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final preferences = await SharedPreferences.getInstance();
  final repository = SettingsRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        settingsProvider.overrideWith(() => SettingsViewModel(repository))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider.notifier);

    return MaterialApp.router(
      title: 'Yeong Mood Tracker',
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: ThemeData(
        useMaterial3: false,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d20,
            letterSpacing: -0.025,
          ),
          titleMedium: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d18,
            letterSpacing: -0.025,
          ),
          titleSmall: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d16,
            letterSpacing: -0.025,
          ),
          bodyLarge: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d18,
            letterSpacing: -0.025,
          ),
          bodyMedium: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d16,
            letterSpacing: -0.025,
          ),
          bodySmall: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d14,
            letterSpacing: -0.025,
          ),
          labelLarge: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d14,
            letterSpacing: -0.025,
          ),
          labelSmall: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d12,
            letterSpacing: -0.025,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d20,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d18,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d16,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d18,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d16,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d14,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d14,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d12,
            letterSpacing: -0.025,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
