import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF58CC02),
  scaffoldBackgroundColor: const Color(0xFFF7F7F7),
  fontFamily: 'Inter',
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF58CC02),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontFamily: 'Inter',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF58CC02),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF58CC02),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF58CC02),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF58CC02),
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w800, color: Color(0xFF58CC02)),
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
  ),
);