part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginError extends LoginState {}

class SendCodeLoading extends LoginState {}

class CheckCodeInvalidCode extends LoginState {}

class CheckCodeSuccessfully extends LoginState {}

class OnSmsCodeSent extends LoginState {
  final String sms;

  OnSmsCodeSent(this.sms);
}
