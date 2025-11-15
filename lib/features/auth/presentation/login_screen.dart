import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/core/widgets/custom_button.dart';

class WelcomeBackLoginScreen extends StatelessWidget {
  const WelcomeBackLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryTextColor = theme.textTheme.titleLarge?.color ??
        (isDark ? AppColors.darkText : AppColors.lightText);
    final secondaryTextColor = theme.textTheme.bodyMedium?.color ??
        (isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: theme.iconTheme.color ??
                            (isDark ? AppColors.darkText : AppColors.lightText),
                        splashRadius: AppSpacing.lg + AppSpacing.sm,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl + AppSpacing.lg),
                    const SizedBox(height: AppSpacing.lg),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.cardRadius),
                      child: Image.asset(
                        'assets/images/login.png',
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl + AppSpacing.sm),
                    Text(
                      AppStrings.loginTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: primaryTextColor,
                          ) ??
                          TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: primaryTextColor,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppStrings.loginSubtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                            color: secondaryTextColor,
                          ) ??
                          TextStyle(
                            fontSize: 14,
                            color: secondaryTextColor,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xl + AppSpacing.sm),
                    CustomButton(
                      label: AppStrings.loginGoogleButton,
                      height: 56,
                      radius: AppSpacing.radius * 2,
                      color: AppColors.primary,
                      icon: Image.asset(
                        'assets/icons/google-2.png',
                        height: 22,
                        color: Colors.white,
                      ),
                      onPressed: () => context.push('/complete-profile'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text.rich(
                      TextSpan(
                        text: AppStrings.loginTermsPrefix,
                        style: theme.textTheme.bodySmall?.copyWith(
                              color: secondaryTextColor,
                            ) ??
                            TextStyle(
                              fontSize: 12,
                              color: secondaryTextColor,
                            ),
                        children: const [
                          TextSpan(
                            text: AppStrings.loginTerms,
                            style: TextStyle(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' & '),
                          TextSpan(
                            text: AppStrings.loginPrivacyPolicy,
                            style: TextStyle(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
