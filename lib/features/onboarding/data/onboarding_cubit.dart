
import 'package:eazy/features/onboarding/data/onboarding_datasource.dart';
import 'package:eazy/features/onboarding/data/onboarding_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRemoteDataSource remoteDataSource;

  OnboardingCubit(this.remoteDataSource) : super(OnboardingInitial());

  void fetchOnboarding() async {
    emit(OnboardingLoading());
    try {
      final slides = await remoteDataSource.getOnboardingData();
      emit(OnboardingLoaded(slides));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
