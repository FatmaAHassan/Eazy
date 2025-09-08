part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  ProfileLoaded(this.profile);
}
class ProfileUpdated extends ProfileState {
  final UserProfile profile;
  final String message;
  ProfileUpdated(this.profile, this.message);
}


class ProfileSuccess extends ProfileState {
  final String message;
  ProfileSuccess(this.message) {
    print("✅ State: ProfileSuccess → $message");
  }
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message) {
    print("❌ State: ProfileError → $message");
  }
}
