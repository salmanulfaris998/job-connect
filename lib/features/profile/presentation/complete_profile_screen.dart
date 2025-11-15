import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/core/widgets/custom_button.dart';
import 'package:jobconnect/core/widgets/custom_text_field.dart';
import 'package:jobconnect/features/profile/providers/complete_profile_provider.dart';

class CompleteProfileScreen extends ConsumerWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(completeProfileProvider);
    final notifier = ref.read(completeProfileProvider.notifier);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    TextEditingController controllerFor(String value) {
      return TextEditingController(text: value)
        ..selection = TextSelection.collapsed(offset: value.length);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔵 Top Icon
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF3B7BFF), Color(0xFF0056FF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Icon(Icons.work_outline,
                      color: Colors.white, size: 30),
                ),
              ),

              const SizedBox(height: 24),

              // TITLE
              Center(
                child: Text(
                  "Complete Your Profile",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppColors.lightText,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Center(
                child: Text(
                  "A complete profile gets you noticed faster.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: isDark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // STEP INDICATOR
              Text(
                "Step ${formState.currentStep + 1} of ${formState.totalSteps}: ${_stepTitle(formState.currentStep)}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.darkSecondaryText : Colors.black54,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                height: 5,
                decoration: BoxDecoration(
                  color: (isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor:
                      (formState.currentStep + 1) / formState.totalSteps,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (formState.currentStep == 0) ...[
                _sectionCard(
                  context: context,
                  title: "Basic Information",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hint: "Enter your full name",
                        controller: controllerFor(formState.fullName),
                        onChanged: notifier.updateFullName,
                      ),
                      if (formState.fieldErrors[_fullNameField] != null)
                        _fieldErrorText(
                            context, formState.fieldErrors[_fullNameField]!),
                      const SizedBox(height: 16),
                      Text(
                        "Phone Number",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hint: "+91 00000 00000",
                        controller: controllerFor(formState.phoneNumber),
                        prefix: Icon(
                          Icons.phone,
                          size: 18,
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.none,
                        onChanged: notifier.updatePhoneNumber,
                      ),
                      if (formState.fieldErrors[_phoneField] != null)
                        _fieldErrorText(
                            context, formState.fieldErrors[_phoneField]!),
                      const SizedBox(height: 16),
                      Text(
                        "Job Category",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.lightCard.withOpacity(0.1)
                                : AppColors.lightCard,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder)
                                  .withOpacity(isDark ? 0.4 : 0.6),
                            ),
                          ),
                          child: Theme(
                            data: theme.copyWith(
                              canvasColor:
                                  isDark ? AppColors.darkCard : AppColors.lightCard,
                              textTheme: theme.textTheme.apply(
                                bodyColor:
                                    isDark ? AppColors.darkText : AppColors.lightText,
                                displayColor:
                                    isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: formState.jobCategory.isEmpty
                                  ? null
                                  : formState.jobCategory,
                              isExpanded: true,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: isDark
                                    ? AppColors.darkSecondaryText
                                    : AppColors.lightSecondaryText,
                              ),
                              dropdownColor: isDark
                                  ? AppColors.darkCard
                                  : AppColors.lightCard,
                              hint: Text(
                                "Select a category",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isDark
                                      ? AppColors.darkSecondaryText
                                      : AppColors.lightSecondaryText,
                                  fontSize: 15,
                                ),
                              ),
                              onChanged: (value) {
                                notifier.updateJobCategory(value ?? '');
                              },
                              items: _jobCategories
                                  .map(
                                    (category) => DropdownMenuItem<String>(
                                      value: category,
                                      child: Text(
                                        category,
                                        style:
                                            theme.textTheme.bodyMedium?.copyWith(
                                          color: isDark
                                              ? Colors.white
                                              : AppColors.lightText,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      if (formState.fieldErrors[_jobCategoryField] != null)
                        _fieldErrorText(
                            context, formState.fieldErrors[_jobCategoryField]!),
                      const SizedBox(height: 16),
                      Text(
                        "Short Bio",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hint: "Tell us a little about your experience...",
                        controller: controllerFor(formState.bio),
                        multiline: true,
                        onChanged: notifier.updateBio,
                      ),
                      if (formState.fieldErrors[_bioField] != null)
                        _fieldErrorText(
                            context, formState.fieldErrors[_bioField]!),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
              ],

              if (formState.currentStep == 1) ...[
                _sectionCard(
                  context: context,
                  title: "Add Your Skills",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hint: "Type a skill and press enter",
                        onSubmitted: (value) {
                          notifier.addSkillFromInput(value);
                        },
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                      ),
                      if (formState.fieldErrors[_skillsField] != null)
                        _fieldErrorText(
                            context, formState.fieldErrors[_skillsField]!),
                      const SizedBox(height: 16),
                      Text(
                        "Suggestions for you:",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          for (final skill in formState.skillSuggestions)
                            _skillChip(
                              context,
                              skill,
                              selected:
                                  formState.selectedSkills.contains(skill),
                              onTap: () => notifier.toggleSkill(skill),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 26),
              ],

              if (formState.currentStep == 2) ...[
                _sectionCard(
                  context: context,
                  title: "Set Your Location",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hint: "e.g., Mumbai, Maharashtra",
                        controller: controllerFor(formState.location),
                        onChanged: notifier.updateLocation,
                      ),
                      if (formState.fieldErrors[_locationField] != null)
                        _fieldErrorText(
                            context, formState.fieldErrors[_locationField]!),
                      const SizedBox(height: 16),
                      Container(
                        height: 54,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF1A73E8)),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.my_location,
                                  size: 18, color: Color(0xFF1A73E8)),
                              SizedBox(width: 8),
                              Text(
                                "Use Current Location",
                                style: TextStyle(
                                  color: Color(0xFF1A73E8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
              ],

              const SizedBox(height: 40),

              // SAVE BUTTON
              _SubmitButton(
                formState: formState,
                notifier: notifier,
                isDark: isDark,
              ),

              if (formState.currentStep > 0) ...[
                const SizedBox(height: 16),
                CustomButton(
                  label: 'Previous',
                  onPressed: notifier.previousStep,
                  isOutlined: true,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  color: AppColors.primary,
                  textColor: AppColors.primary,
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ------- SECTION CARD WIDGET -------
  Widget _sectionCard({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark ? AppColors.darkCard : Colors.white;
    final borderColor =
        isDark ? Colors.white.withOpacity(0.08) : AppColors.lightBorder;
    final titleColor = isDark ? Colors.white : AppColors.lightText;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                ) ??
                TextStyle(
                  color: titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ------- SUGGESTION CHIP -------
  Widget _skillChip(
    BuildContext context,
    String label, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final chipColor = selected
        ? AppColors.primary.withOpacity(isDark ? 0.25 : 0.12)
        : (isDark ? const Color(0xFF1F2A3A) : AppColors.lightCard);
    final borderColor = selected
        ? AppColors.primary
        : (isDark
            ? Colors.white.withOpacity(0.08)
            : AppColors.primary.withOpacity(0.25));
    final textColor = selected
        ? AppColors.primary
        : (isDark ? Colors.white : AppColors.primary);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          "+  $label",
          style: theme.textTheme.bodySmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ) ??
              TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.formState,
    required this.notifier,
    required this.isDark,
  });

  final CompleteProfileState formState;
  final CompleteProfileNotifier notifier;
  final bool isDark;

  bool get _canSubmit {
    switch (formState.currentStep) {
      case 0:
        return formState.fullName.trim().isNotEmpty &&
            formState.phoneNumber.trim().isNotEmpty &&
            formState.jobCategory.trim().isNotEmpty &&
            formState.bio.trim().isNotEmpty;
      case 1:
        return true; // allow submission to surface validation errors
      case 2:
        return formState.location.trim().isNotEmpty;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor =
        formState.errorMessage != null ? AppColors.danger : AppColors.success;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (formState.errorMessage != null ||
            formState.successMessage != null) ...[
          Text(
            formState.errorMessage ?? formState.successMessage!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ) ??
                TextStyle(
                  color: statusColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
        ],
        CustomButton(
          label: "Save and Continue",
          onPressed: _canSubmit ? notifier.submit : null,
          isLoading: formState.isSubmitting,
          isDisabled: !_canSubmit,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

String _stepTitle(int currentStep) {
  switch (currentStep) {
    case 0:
      return 'Basic Info';
    case 1:
      return 'Skills';
    case 2:
      return 'Location';
    default:
      return '';
  }
}

const _fullNameField = 'fullName';
const _phoneField = 'phoneNumber';
const _jobCategoryField = 'jobCategory';
const _bioField = 'bio';
const _skillsField = 'skills';
const _locationField = 'location';

const List<String> _jobCategories = [
  'Skilled',
  'Unskilled',
  'Part-time',
  'Home Services',
  'Cooking',
  'Delivery / Driving',
  'Construction',
  'Tutoring',
  'Tech',
  'Tailoring',
  'Electrical / Plumbing',
  'Babysitting',
  'Housekeeping',
  'Translation / Data',
  'Event & Wedding Work',
  'Farming',
  'Beauty & Grooming',
  'Pet Care',
  'Freelance / Online',
  'Sales & Retail',
];

Widget _fieldErrorText(BuildContext context, String message) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Text(
      message,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: AppColors.danger)
          .copyWith(),
    ),
  );
}
