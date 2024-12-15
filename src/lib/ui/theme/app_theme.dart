import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: kcPrimaryColor,
    colorScheme: ColorScheme.light(
      primary: kcPrimaryColor,
      secondary: kcSecondaryColor,
      surface: kcSurfaceWhite,
      background: kcBackgroundColor,
      error: kcErrorRed,
    ),
    scaffoldBackgroundColor: kcBackgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: kcSurfaceWhite,
      foregroundColor: kcTextPrimary,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: kcShadowColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kcSurfaceWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kcLightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kcLightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kcPrimaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kcErrorRed),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: kcTextPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: kcTextPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: kcTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: kcTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: kcTextSecondary,
      ),
    ),
  );
}
