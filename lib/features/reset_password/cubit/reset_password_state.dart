part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}
class CheckPhoneError extends ResetPasswordState {}
class CheckPhoneLoaded extends ResetPasswordState {}

class SendCodeLoading extends ResetPasswordState {}
class CheckCodeInvalidCode extends ResetPasswordState {}
class ChangePasswordIconStat extends ResetPasswordState {}
class resetPasswordError extends ResetPasswordState {}
class resetPasswordLoaded extends ResetPasswordState {}


class ModelExistState extends ResetPasswordState {}
class ModelDoesNotExist extends ResetPasswordState {}

class CheckCodeSuccessfully extends ResetPasswordState {}

class OnSmsCodeSent extends ResetPasswordState {
   String sms;

  OnSmsCodeSent(this.sms);
}
