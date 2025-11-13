class Validators {
  // ---------------------------
  // GENERAL
  // ---------------------------
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // ---------------------------
  // NAME VALIDATION
  // ---------------------------
  static String? name(String? value) {
    if (value == null || value.isEmpty) return 'Enter your full name';
    if (value.length < 3) return 'Enter a valid name';
    return null;
  }

  // ---------------------------
  // PHONE NUMBER VALIDATION
  // ---------------------------
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Enter phone number';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  // ---------------------------
  // WHATSAPP NUMBER
  // ---------------------------
  static String? whatsapp(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Invalid WhatsApp number';
    }
    return null;
  }

  // ---------------------------
  // JOB TITLE
  // ---------------------------
  static String? jobTitle(String? value) {
    if (value == null || value.isEmpty) return 'Enter job title';
    if (value.length < 3) return 'Job title too short';
    return null;
  }

  // ---------------------------
  // PAY AMOUNT
  // ---------------------------
  static String? amount(String? value) {
    if (value == null || value.isEmpty) return 'Enter an amount';
    final num? parsed = num.tryParse(value);
    if (parsed == null || parsed <= 0) return 'Enter a valid number';
    return null;
  }

  // ---------------------------
  // DESCRIPTION
  // ---------------------------
  static String? description(String? value) {
    if (value == null || value.isEmpty) return 'Enter job description';
    if (value.length < 10) return 'Description is too short';
    return null;
  }

  // ---------------------------
  // RATING COMMENT (optional)
  // ---------------------------
  static String? comment(String? value) {
    if (value != null && value.length > 250) {
      return 'Comment too long';
    }
    return null;
  }
}
