import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final bool isOutlined;
  final Widget? icon;
  final double height;
  final double radius;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.isOutlined = false,
    this.icon,
    this.height = 54,
    this.radius = 14,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? const Color(0xFF1A73E8);
    final disabledColor = Colors.grey.shade600.withOpacity(0.3);

    final isButtonDisabled = isDisabled || isLoading;

    return Opacity(
      opacity: isButtonDisabled ? 0.6 : 1,
      child: InkWell(
        onTap: isButtonDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isOutlined
                ? Colors.transparent
                : (isButtonDisabled ? disabledColor : themeColor),
            borderRadius: BorderRadius.circular(radius),
            border: isOutlined
                ? Border.all(
                    color: themeColor,
                    width: 2,
                  )
                : null,
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        const SizedBox(width: 10),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          color: isOutlined
                              ? themeColor
                              : (textColor ?? Colors.white),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
