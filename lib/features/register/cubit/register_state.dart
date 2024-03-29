part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterFailedState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailedUserExistState extends RegisterState {}

class ChangePasswordIcon extends RegisterState {}

class CheckTokenFailedState extends RegisterState {}

class CheckTokenSuccessState extends RegisterState {}
