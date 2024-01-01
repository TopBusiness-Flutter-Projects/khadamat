part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginError extends LoginState {}

//
// class ModelExistState extends LoginState {}
// class ModelDoesNotExist extends LoginState {}

class ChangePasswordIconState extends LoginState {}


// class RegisterSuccessState extends LoginState {}
// class RegisterFailedState extends LoginState {}
// class RegisterFailedUserExistState extends LoginState {}


