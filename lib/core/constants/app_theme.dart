import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // =========================
  // APP COLORS
  // =========================

  static const Color primaryGreen = Color(0xFF138A49);
  static const Color darkGreen = Color(0xFF0B6535);
  static const Color lightGreen = Color(0xFFE0E9E4);

  static const Color background = Color(0xFFF7F7F7);
  static const Color white = Colors.white;

  static const Color darkText = Color(0xFF202020);
  static const Color greyText = Color(0xFF777777);
  static const Color lightGrey = Color(0xFFE8E8E8);

  static const Color gold = Color(0xFFC99A45);

  // Alias to support screens expecting 'accentGold'
  static const Color accentGold = gold;

  // =========================
  // THEME
  // =========================

  static ThemeData theme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: white,
      elevation: 0,
      centerTitle: false,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: darkText,
        fontSize: 15,
      ),

      bodyMedium: TextStyle(
        color: greyText,
        fontSize: 14,
      ),

      titleLarge: TextStyle(
        color: darkText,
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),

      titleMedium: TextStyle(
        color: darkText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    // =========================
    // INPUT FIELDS
    // =========================

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightGreen,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),

      hintStyle: const TextStyle(
        color: Color(0xFF999999),
        fontSize: 13,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: primaryGreen,
          width: 1.3,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),

    // =========================
    // BUTTONS
    // =========================

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: white,

        minimumSize: const Size(
          double.infinity,
          54,
        ),

        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),

        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  // Alias getter to support screens expecting 'lightTheme'
  static ThemeData get lightTheme => theme;
}