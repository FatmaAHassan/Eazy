
import 'package:equatable/equatable.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object?> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifySuccess extends VerifyState {
  final String message;
  const VerifySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyFailure extends VerifyState {
  final String message;
  const VerifyFailure(this.message);

  @override
  List<Object?> get props => [message];
}
