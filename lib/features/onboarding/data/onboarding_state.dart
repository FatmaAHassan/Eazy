part of 'onboarding_cubit.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}
class OnboardingLoading extends OnboardingState {}
class OnboardingLoaded extends OnboardingState {
  final List<OnboardingModel> slides;
  OnboardingLoaded(this.slides);
}
class OnboardingError extends OnboardingState {
  final String message;
  OnboardingError(this.message);
}
