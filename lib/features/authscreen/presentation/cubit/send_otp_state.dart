
import 'package:equatable/equatable.dart';

abstract class SendOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtpInitial extends SendOtpState {}

class SendOtpLoading extends SendOtpState {}

class SendOtpSuccess extends SendOtpState {
  final String message;
  SendOtpSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SendOtpFailure extends SendOtpState {
  final String message;
  SendOtpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
