
import 'package:equatable/equatable.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object?> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordSuccess extends UpdatePasswordState {
  final String message;

  const UpdatePasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatePasswordFailure extends UpdatePasswordState {
  final String error;

  const UpdatePasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}
