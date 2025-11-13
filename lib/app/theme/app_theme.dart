import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';

class AppTheme {
  // -----------------------------
  // LIGHT THEME
  // -----------------------------
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightCard,
      extensions: const [
        FilterChipColors(
          activeBackground: AppColors.primary,
          inactiveBackground: AppColors.lightFilterChip,
          inactiveText: Colors.black87,
          activeText: Colors.white,
        ),
      ],

      textTheme: const TextTheme(
        titleLarge: AppTextStyle.headline, // 22, bold
        titleMedium: AppTextStyle.title, // 18, semi-bold
        titleSmall: AppTextStyle.subtitle, // 15, medium

        bodyLarge: AppTextStyle.body, // 14
        bodyMedium: AppTextStyle.body, // 14
        bodySmall: AppTextStyle.small, // 12
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightCard,
        elevation: 0.4,
        foregroundColor: AppColors.lightText,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightSecondaryText,
        type: BottomNavigationBarType.fixed,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
          ),
        ),
      ),
    );
  }

  // -----------------------------
  // DARK THEME
  // -----------------------------
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.darkCard,
      extensions: const [
        FilterChipColors(
          activeBackground: AppColors.primary,
          inactiveBackground: AppColors.darkFilterChip,
          inactiveText: Colors.white70,
          activeText: Colors.white,
        ),
      ],

      textTheme: TextTheme(
        titleLarge: AppTextStyle.headline, // 22, bold
        titleMedium: AppTextStyle.title, // 18, semi-bold
        titleSmall: AppTextStyle.subtitle, // 15, medium

        bodyLarge: AppTextStyle.body, // 14
        bodyMedium: AppTextStyle.body, // 14
        bodySmall: AppTextStyle.small, // 12
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkCard,
        elevation: 0.4,
        foregroundColor: AppColors.darkText,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkSecondaryText,
        type: BottomNavigationBarType.fixed,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
          ),
        ),
      ),
    );
  }
}
