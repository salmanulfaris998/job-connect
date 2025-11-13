import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/theme/colors.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;

  const CustomSearchField({
    super.key,
    this.hintText = "Search for a job or skill",
    this.onChanged,
    this.onTap,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.darkCard : theme.cardColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: AppColors.primary.withOpacity(isDark ? 0.6 : 0.4),
          width: 1.2,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Iconsax.search_normal,
            size: 22,
            color: isDark ? AppColors.primary : Colors.grey.shade500,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 16,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
