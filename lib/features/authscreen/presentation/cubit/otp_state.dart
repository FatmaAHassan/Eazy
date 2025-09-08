import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;
  const OtpSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OtpFailure extends OtpState {
  final String message;
  const OtpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
