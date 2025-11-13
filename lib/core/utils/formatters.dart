import 'package:flutter/services.dart';

class InputFormatters {
  // DIGITS ONLY
  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;

  // PHONE NUMBER (0-9)
  static final phone = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  // REMOVE EMOJIS
  static final noEmoji = FilteringTextInputFormatter.deny(
    RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true),
  );

  // LIMIT TO 10 DIGITS
  static TextInputFormatter maxLength(int length) {
    return LengthLimitingTextInputFormatter(length);
  }

  // MONEY FORMATTER INPUT
  static final amount = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  // BLOCK SPECIAL CHARACTERS
  static final noSpecialChars = FilteringTextInputFormatter.deny(
    RegExp(r'[!@#%^&*(),?":{}|<>]'),
  );
}
