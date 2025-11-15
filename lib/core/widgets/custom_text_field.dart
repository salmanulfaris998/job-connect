import 'package:flutter/material.dart';
import 'package:jobconnect/app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool multiline;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool enabled;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    required this.hint,
    this.prefix,
    this.suffix,
    this.multiline = false,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
        isDark ? AppColors.lightCard.withOpacity(0.1) : AppColors.lightCard;
    final textColor = isDark ? Colors.white : AppColors.lightText;
    final hintColor =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor.withOpacity(isDark ? 0.4 : 0.6)),
      ),
      child: TextField(
        maxLines: multiline ? 4 : 1,
        cursorColor: theme.primaryColor,
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
        focusNode: focusNode,
        enabled: enabled,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction ??
            (multiline ? TextInputAction.newline : TextInputAction.done),
        style: TextStyle(color: textColor, fontSize: 15),
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 15,
          ),
          prefixIcon: prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: prefix!,
                )
              : null,
          prefixIconConstraints: prefix != null
              ? const BoxConstraints(minWidth: 0, minHeight: 0)
              : null,
          suffixIcon: suffix,
          suffixIconConstraints: suffix != null
              ? const BoxConstraints(minWidth: 0, minHeight: 0)
              : null,
        ),
      ),
    );
  }
}
