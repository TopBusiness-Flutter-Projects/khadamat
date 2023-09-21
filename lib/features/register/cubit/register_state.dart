part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterFailedState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterFailedUserExistState extends RegisterState {}
class ChangePasswordIcon extends RegisterState {}




