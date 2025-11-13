import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  bool get isEmail => contains('@') && contains('.');

  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  int toInt() => int.tryParse(this) ?? 0;

  double toDouble() => double.tryParse(this) ?? 0.0;
}

extension DateExtensions on DateTime {
  String format([String pattern = 'dd MMM yyyy']) {
    return DateFormat(pattern).format(this);
  }

  String get timeAgo {
    final diff = DateTime.now().difference(this);

    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}

extension WidgetPadding on Widget {
  Widget pad(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget padH(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  Widget padV(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );
}

extension ColorHex on String {
  Color toColor() {
    String code = replaceAll("#", "");
    if (code.length == 6) code = "FF$code";
    return Color(int.parse(code, radix: 16));
  }
}
