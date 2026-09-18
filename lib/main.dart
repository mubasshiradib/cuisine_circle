import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CuisineCircleApp());
}

class CuisineCircleApp extends StatelessWidget {
  const CuisineCircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuisine Circle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F5F2), // Warm off-white
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D2013),
          surface: const Color(0xFFF8F5F2),
        ),
      ),
      home: const Splash(),
    );
  }
}
