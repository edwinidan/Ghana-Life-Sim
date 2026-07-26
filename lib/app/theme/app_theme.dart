import 'package:flutter/material.dart';

abstract final class AppColors {
  static const cocoa = Color(0xFF2B2118);
  static const green = Color(0xFF177245);
  static const gold = Color(0xFFD4A017);
  static const red = Color(0xFFA83A32);
  static const cream = Color(0xFFFFF9EE);
  static const surface = Color(0xFFFFFFFF);
  static const muted = Color(0xFF68635D);
  static const divider = Color(0xFFE7DFD2);
}

abstract final class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.light,
      primary: AppColors.green,
      secondary: AppColors.gold,
      error: AppColors.red,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.cream,
      fontFamily: 'Roboto',
      dividerColor: AppColors.divider,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: AppColors.cocoa,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        headlineSmall: TextStyle(
          color: AppColors.cocoa,
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: AppColors.cocoa,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(color: AppColors.cocoa, height: 1.45),
        bodyMedium: TextStyle(color: AppColors.cocoa, height: 1.4),
        bodySmall: TextStyle(color: AppColors.muted, height: 1.35),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.cocoa,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.green, width: 2),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.cocoa,
      ),
    );
  }
}
