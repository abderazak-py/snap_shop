part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess({required this.user});
}

class AuthOtpSuccess extends AuthState {
  AuthOtpSuccess();
}

class AuthSuccessConfirmed extends AuthState {
  final UserEntity user;

  AuthSuccessConfirmed({required this.user});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

class OtpTimerChanged extends AuthState {
  final int secondsRemaining;
  final bool showSendButton;

  OtpTimerChanged({
    required this.secondsRemaining,
    required this.showSendButton,
  });
}
