import 'package:flutter/material.dart';

class AppTextStyle {
  // Headline Bold
  static const TextStyle headline = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  // Title
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Subtitle
  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  // Body text
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // Small text
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle lightText(Color color) => TextStyle(color: color);

  static TextStyle darkText(Color color) => TextStyle(color: color);
}
