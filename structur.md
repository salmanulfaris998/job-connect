lib/
│
├── main.dart
├── app/
│   ├── app.dart                     # Root MaterialApp with GoRouter
│   ├── routes.dart                  # All route definitions
│   ├── theme/
│   │   ├── app_theme.dart           # ThemeData (Material 3 setup)
│   │   ├── colors.dart              # Custom color tokens from Stitch
│   │   ├── typography.dart          # Text styles
│   │   └── spacing.dart             # Standard paddings/margins
│   └── constants/
│       ├── app_strings.dart         # UI text constants
│       ├── app_icons.dart           # Centralized icons
│       ├── app_assets.dart          # Asset paths (images, icons)
│       └── app_config.dart          # Environment, version info
│
├── core/
│   ├── models/                      # Core data models used across app
│   │   ├── user_model.dart
│   │   ├── job_model.dart
│   │   ├── message_model.dart
│   │   ├── rating_model.dart
│   │   ├── skill_model.dart
│   │   └── support_ticket_model.dart
│   │
│   ├── services/                    # App-wide services
│   │   ├── supabase_service.dart    # Supabase client instance
│   │   ├── location_service.dart    # Geolocation handling
│   │   ├── notification_service.dart# Push notifications
│   │   ├── storage_service.dart     # Upload/Delete images (Supabase bucket)
│   │   └── analytics_service.dart   # Optional for tracking
│   │
│   ├── utils/                       # Reusable helpers
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   ├── extensions.dart
│   │   └── helpers.dart
│   │
│   └── widgets/                     # Shared widgets across app
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── job_card.dart
│       ├── rating_bar.dart
│       └── empty_state.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_repository.dart
│   │   ├── presentation/
│   │   │   ├── login_screen.dart
│   │   │   ├── onboarding_screen.dart
│   │   │   ├── splash_screen.dart
│   │   │   └── complete_profile_screen.dart
│   │   └── providers/
│   │       ├── auth_provider.dart
│   │       └── user_notifier.dart
│   │
│   ├── home/
│   │   ├── data/
│   │   │   ├── job_repository.dart
│   │   ├── presentation/
│   │   │   ├── home_screen.dart
│   │   │   ├── job_card_widget.dart
│   │   │   ├── category_list_widget.dart
│   │   │   └── search_bar_widget.dart
│   │   └── providers/
│   │       ├── job_list_provider.dart
│   │       └── category_provider.dart
│   │
│   ├── job/
│   │   ├── data/
│   │   │   ├── job_repository.dart
│   │   ├── presentation/
│   │   │   ├── post_job_screen.dart
│   │   │   ├── edit_job_screen.dart
│   │   │   ├── view_applicants_screen.dart
│   │   │   ├── job_detail_screen.dart
│   │   │   └── job_filters_widget.dart
│   │   └── providers/
│   │       ├── job_detail_provider.dart
│   │       ├── post_job_notifier.dart
│   │       └── applicant_provider.dart
│   │
│   ├── chat/
│   │   ├── data/
│   │   │   ├── chat_repository.dart
│   │   ├── presentation/
│   │   │   ├── chat_list_screen.dart
│   │   │   ├── chat_screen.dart
│   │   │   └── message_bubble_widget.dart
│   │   └── providers/
│   │       ├── chat_provider.dart
│   │       └── message_notifier.dart
│   │
│   ├── profile/
│   │   ├── data/
│   │   │   ├── profile_repository.dart
│   │   ├── presentation/
│   │   │   ├── profile_screen.dart
│   │   │   ├── edit_profile_screen.dart
│   │   │   ├── view_public_profile_screen.dart
│   │   │   ├── badges_screen.dart
│   │   │   ├── skills_screen.dart
│   │   │   ├── my_earnings_screen.dart
│   │   │   └── all_reviews_screen.dart
│   │   └── providers/
│   │       ├── profile_provider.dart
│   │       ├── badges_provider.dart
│   │       ├── skill_provider.dart
│   │       └── rating_provider.dart
│   │
│   ├── support/
│   │   ├── data/
│   │   │   ├── support_repository.dart
│   │   ├── presentation/
│   │   │   ├── help_support_screen.dart
│   │   │   ├── faq_widget.dart
│   │   │   └── support_form_screen.dart
│   │   └── providers/
│   │       ├── support_provider.dart
│   │       └── faq_provider.dart
│   │
│   ├── settings/
│   │   ├── presentation/
│   │   │   ├── app_settings_screen.dart
│   │   │   └── terms_privacy_screen.dart
│   │   └── providers/
│   │       ├── settings_provider.dart
│   │       └── theme_provider.dart
│   │
│   └── notifications/
│       ├── data/
│       │   ├── notification_repository.dart
│       ├── presentation/
│       │   ├── notification_screen.dart
│       └── providers/
│           ├── notification_provider.dart
│           └── notification_notifier.dart
│
└── l10n/
    ├── app_en.arb
    ├── app_ml.arb
    └── localization.dart