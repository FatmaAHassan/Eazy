import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final Failure failure;
  LoginFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
