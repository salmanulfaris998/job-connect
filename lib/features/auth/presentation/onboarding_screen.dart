import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/app/theme/typography.dart';
import 'package:jobconnect/features/auth/providers/onboarding_seen_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();

  int _currentIndex = 0;
  bool _hasNavigated = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNext() {
    final totalSlides = ref.read(onboardingSlidesProvider).length;
    if (totalSlides == 0) return;

    if (_currentIndex >= totalSlides - 1) {
      _goToHome();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void _goToHome() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final slides = ref.watch(onboardingSlidesProvider);

    if (slides.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isLastSlide = _currentIndex >= slides.length - 1;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? const RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [
                    Color(0xFF1A232E),
                    Color(0xFF101922),
                  ],
                )
              : const RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [
                    Color(0xFFE3F2FD),
                    Colors.white,
                  ],
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),

              Text(
                AppStrings.appName,
                style: AppTextStyle.headline.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                AppStrings.splashTagline,
                textAlign: TextAlign.center,
                style: AppTextStyle.body.copyWith(
                  color: (isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText)
                      .withOpacity(0.9),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return _OnboardingSlideView(slide: slide);
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              SmoothPageIndicator(
                controller: _controller,
                count: slides.length,
                effect: ExpandingDotsEffect(
                  dotHeight: AppSpacing.xs,
                  dotWidth: AppSpacing.sm,
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.primary.withOpacity(0.3),
                  expansionFactor: 3,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSpacing.xl + AppSpacing.md,
                  child: ElevatedButton(
                    onPressed: _handleNext,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radius),
                      ),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      isLastSlide
                          ? AppStrings.onboardingButtonGetStarted
                          : AppStrings.onboardingButtonNext,
                      style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlideView extends StatelessWidget {
  const _OnboardingSlideView({required this.slide});

  final OnboardingSlideData slide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.cardRadius * 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.12),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      child: Image.asset(
                        slide.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.primary,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: AppTextStyle.title.copyWith(
              fontSize: AppTextStyle.headline.fontSize,
              fontWeight: FontWeight.w800,
              color: theme.brightness == Brightness.dark
                  ? AppColors.darkText
                  : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: AppTextStyle.body.copyWith(
              color: (theme.brightness == Brightness.dark
                      ? AppColors.darkSecondaryText
                      : AppColors.lightSecondaryText)
                  .withOpacity(0.9),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
