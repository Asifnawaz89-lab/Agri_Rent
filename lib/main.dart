import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/constants/app_theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Direct Web Firebase Connection
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY_HERE",
      appId: "YOUR_APP_ID_HERE",
      messagingSenderId: "YOUR_SENDER_ID_HERE",
      projectId: "agri-rent-xxxx",
    ),
  );

  runApp(const AgriRentApp());
}

class AgriRentApp extends StatelessWidget {
  const AgriRentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriRent',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}