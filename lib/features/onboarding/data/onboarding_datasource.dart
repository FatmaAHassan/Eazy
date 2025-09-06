
import 'package:eazy/core/Api/api_endpoints.dart';
import 'package:eazy/core/Api/api_service.dart';
import 'package:eazy/features/onboarding/data/onboarding_model.dart';

class OnboardingRemoteDataSource {
  final ApiService apiService;

  OnboardingRemoteDataSource(this.apiService);

  Future<List<OnboardingModel>> getOnboardingData() async {
    final response = await apiService.get(ApiEndpoints.onboarding);
    final List data = response.data["data"];
    return data.map((e) => OnboardingModel.fromJson(e)).toList();
  }
}
