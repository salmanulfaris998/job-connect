import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/core/utils/validators.dart';

class CompleteProfileState {
  const CompleteProfileState({
    this.fullName = '',
    this.phoneNumber = '',
    this.jobCategory = '',
    this.bio = '',
    this.location = '',
    this.selectedSkills = const [],
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.skillSuggestions = const [
      'Wiring',
      'Circuit Repair',
      'Appliance Installation',
    ],
    this.currentStep = 0,
    this.totalSteps = 3,
    this.fieldErrors = const {},
    this.shouldNavigateHome = false,
  });

  final String fullName;
  final String phoneNumber;
  final String jobCategory;
  final String bio;
  final String location;
  final List<String> selectedSkills;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final List<String> skillSuggestions;
  final int currentStep;
  final int totalSteps;
  final Map<String, String> fieldErrors;
  final bool shouldNavigateHome;

  static const Object _sentinel = Object();

  CompleteProfileState copyWith({
    String? fullName,
    String? phoneNumber,
    String? jobCategory,
    String? bio,
    String? location,
    List<String>? selectedSkills,
    bool? isSubmitting,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    List<String>? skillSuggestions,
    int? currentStep,
    int? totalSteps,
    Map<String, String>? fieldErrors,
    bool? shouldNavigateHome,
  }) {
    return CompleteProfileState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      jobCategory: jobCategory ?? this.jobCategory,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _sentinel)
          ? this.successMessage
          : successMessage as String?,
      skillSuggestions: skillSuggestions ?? this.skillSuggestions,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      fieldErrors: fieldErrors ?? this.fieldErrors,
      shouldNavigateHome: shouldNavigateHome ?? this.shouldNavigateHome,
    );
  }
}

class CompleteProfileNotifier extends Notifier<CompleteProfileState> {
  static const _fullNameField = 'fullName';
  static const _phoneField = 'phoneNumber';
  static const _jobCategoryField = 'jobCategory';
  static const _bioField = 'bio';
  static const _skillsField = 'skills';
  static const _locationField = 'location';

  @override
  CompleteProfileState build() => const CompleteProfileState();

  Map<String, String> _removeFieldError(String field) {
    final errors = Map<String, String>.from(state.fieldErrors);
    errors.remove(field);
    return errors;
  }

  void updateFullName(String value) {
    state = state.copyWith(
      fullName: value,
      fieldErrors: _removeFieldError(_fullNameField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(
      phoneNumber: value,
      fieldErrors: _removeFieldError(_phoneField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void updateJobCategory(String value) {
    state = state.copyWith(
      jobCategory: value,
      fieldErrors: _removeFieldError(_jobCategoryField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void updateBio(String value) {
    state = state.copyWith(
      bio: value,
      fieldErrors: _removeFieldError(_bioField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void toggleSkill(String skill) {
    final normalized = skill.trim();
    if (normalized.isEmpty) return;

    final skills = [...state.selectedSkills];
    if (skills.contains(normalized)) {
      skills.remove(normalized);
    } else {
      skills.add(normalized);
    }

    state = state.copyWith(
      selectedSkills: skills,
      fieldErrors: _removeFieldError(_skillsField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void addSkillFromInput(String skill) {
    final normalized = skill.trim();
    if (normalized.isEmpty) return;

    final updatedSkills = {
      ...state.selectedSkills,
      normalized,
    }.toList();

    final updatedSuggestions = state.skillSuggestions.contains(normalized)
        ? state.skillSuggestions
        : [normalized, ...state.skillSuggestions];

    state = state.copyWith(
      selectedSkills: updatedSkills,
      skillSuggestions: updatedSuggestions,
      fieldErrors: _removeFieldError(_skillsField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void updateLocation(String value) {
    state = state.copyWith(
      location: value,
      fieldErrors: _removeFieldError(_locationField),
      errorMessage: null,
      successMessage: null,
    );
  }

  void clearStatus() {
    state = state.copyWith(errorMessage: null, successMessage: null);
  }

  void previousStep() {
    if (state.currentStep == 0) return;
    state = state.copyWith(
      currentStep: state.currentStep - 1,
      errorMessage: null,
      successMessage: null,
    );
  }

  List<String> _fieldsForStep(int step) {
    switch (step) {
      case 0:
        return [_fullNameField, _phoneField, _jobCategoryField, _bioField];
      case 1:
        return [_skillsField];
      case 2:
        return [_locationField];
      default:
        return const [];
    }
  }

  bool _validateCurrentStep() {
    final errors = Map<String, String>.from(state.fieldErrors);
    final stepFields = _fieldsForStep(state.currentStep);
    bool hasErrors = false;

    void apply(String field, String? message) {
      if (message != null && message.isNotEmpty) {
        errors[field] = message;
        if (stepFields.contains(field)) {
          hasErrors = true;
        }
      } else {
        errors.remove(field);
      }
    }

    switch (state.currentStep) {
      case 0:
        apply(_fullNameField, Validators.name(state.fullName));
        apply(_phoneField, Validators.phone(state.phoneNumber));
        apply(_jobCategoryField, Validators.required(state.jobCategory));
        apply(_bioField, Validators.description(state.bio));
        break;
      case 1:
        if (state.selectedSkills.isEmpty) {
          apply(_skillsField, 'Select at least one skill');
        } else {
          apply(_skillsField, null);
        }
        break;
      case 2:
        apply(_locationField, Validators.required(state.location));
        break;
    }

    state = state.copyWith(
      fieldErrors: errors,
      errorMessage: hasErrors ? 'Please fix the highlighted fields.' : null,
      successMessage: hasErrors ? null : state.successMessage,
    );

    return !hasErrors;
  }

  void submit() {
    if (state.isSubmitting) return;

    state = state.copyWith(
      isSubmitting: true,
      errorMessage: null,
      successMessage: null,
    );

    final isValid = _validateCurrentStep();

    if (!isValid) {
      state = state.copyWith(isSubmitting: false);
      return;
    }

    if (state.currentStep < state.totalSteps - 1) {
      state = state.copyWith(
        isSubmitting: false,
        currentStep: state.currentStep + 1,
        successMessage: null,
        shouldNavigateHome: false,
      );
    } else {
      state = state.copyWith(
        isSubmitting: false,
        successMessage: 'Profile saved successfully.',
        shouldNavigateHome: true,
      );
    }
  }

  void acknowledgeNavigationHandled() {
    if (!state.shouldNavigateHome) return;
    state = state.copyWith(shouldNavigateHome: false);
  }
}

final completeProfileProvider =
    NotifierProvider<CompleteProfileNotifier, CompleteProfileState>(
  CompleteProfileNotifier.new,
);
