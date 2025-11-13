import 'package:flutter/material.dart';

class AppColors {
  // Primary brand color
  static const Color primary = Color(0xFF0066FF);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightCard = Colors.white;
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightSecondaryText = Color(0xFF6B7280);
  static const Color lightBorder = Color(0xFFE5E7EB);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkCard = Color(0xFF161B22);
  static const Color darkText = Color(0xFFEDEDED);
  static const Color darkSecondaryText = Color(0xFF9CA3AF);
  static const Color darkBorder = Color(0xFF262D34);

  // Filter chips
  static const Color lightFilterChip = Color(0xFFD7E3FF);
  static const Color darkFilterChip = Color(0xFF142446);

  // Status colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFACC15);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Chat bubbles
  static const Color myMessage = Color(0xFF0066FF);
  static const Color otherMessage = Color(0xFF262D34);
}

class FilterChipColors extends ThemeExtension<FilterChipColors> {
  const FilterChipColors({
    required this.activeBackground,
    required this.inactiveBackground,
    required this.inactiveText,
    required this.activeText,
  });

  final Color activeBackground;
  final Color inactiveBackground;
  final Color inactiveText;
  final Color activeText;

  @override
  FilterChipColors copyWith({
    Color? activeBackground,
    Color? inactiveBackground,
    Color? inactiveText,
    Color? activeText,
  }) {
    return FilterChipColors(
      activeBackground: activeBackground ?? this.activeBackground,
      inactiveBackground: inactiveBackground ?? this.inactiveBackground,
      inactiveText: inactiveText ?? this.inactiveText,
      activeText: activeText ?? this.activeText,
    );
  }

  @override
  FilterChipColors lerp(ThemeExtension<FilterChipColors>? other, double t) {
    if (other is! FilterChipColors) return this;
    return FilterChipColors(
      activeBackground: Color.lerp(activeBackground, other.activeBackground, t)!,
      inactiveBackground:
          Color.lerp(inactiveBackground, other.inactiveBackground, t)!,
      inactiveText: Color.lerp(inactiveText, other.inactiveText, t)!,
      activeText: Color.lerp(activeText, other.activeText, t)!,
    );
  }
}
