import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_profile.dart';
import '../services/profile_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;

  ProfileCubit(this.profileService) : super(ProfileInitial());

  /// 🟢 Get Profile
  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final res = await profileService.getProfile();
      print("📌 Response getProfile: $res");
      final profile = UserProfile.fromJson(res["data"]);
      emit(ProfileLoaded(profile));
    } catch (e) {
      print("❌ Error in getProfile: $e");
      emit(ProfileError("Error loading profile: $e"));
    }
  }

  /// 🟡 Update Profile
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) async {
    emit(ProfileLoading());
    try {
      final response = await profileService.updateProfile(
        name: name,
        email: email,
        phone: phone,
        image: image,
      );

      if (response["success"] == true) {
        final updatedRes = await profileService.getProfile();
        final updatedProfile = UserProfile.fromJson(updatedRes["data"]);
        emit(ProfileUpdated(updatedProfile, response["message"] ?? "تم التحديث بنجاح ✅"));

      } else {
        emit(ProfileError(response["message"] ?? "فشل التحديث ❌"));
      }
    } catch (e) {
      emit(ProfileError("حدث خطأ أثناء تحديث الحساب: $e"));
    }
  }


}

      // print("❌ Error in updateProfile: $e");
      // print("📌 StackTrace: $s");
      // print("📌 Response getProfile after update: $updatedRes");
