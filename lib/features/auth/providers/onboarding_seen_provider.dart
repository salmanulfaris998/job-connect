import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/app/constants/app_strings.dart';

class OnboardingSlideData {
  const OnboardingSlideData({
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
}

final onboardingSlidesProvider = Provider<List<OnboardingSlideData>>((ref) {
  return const [
    OnboardingSlideData(
      image: 'assets/onboarding/slide1.png',
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDescription1,
    ),
    OnboardingSlideData(
      image: 'assets/onboarding/slide2.png',
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDescription2,
    ),
    OnboardingSlideData(
      image: 'assets/onboarding/slide3.png',
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDescription3,
    ),
  ];
});
