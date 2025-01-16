import 'package:airsens/core/sqflite_db/databaseHelper.dart';
import 'package:airsens/core/theme/theme.dart';
import 'package:airsens/features/home/screens/home_screen.dart';
import 'package:airsens/features/home/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Sense',
      theme: Palette.lightModeAppTheme,
      home: const SplashScreen(),
    );
  }
}
