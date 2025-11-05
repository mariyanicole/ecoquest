import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/welcome_screen.dart';
import 'package:ecoquest/user_progress_provider.dart';
import 'package:ecoquest/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProgressProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'EcoQuest',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
    home: const WelcomeScreen(),
        ),
      ),
    );
  }
}