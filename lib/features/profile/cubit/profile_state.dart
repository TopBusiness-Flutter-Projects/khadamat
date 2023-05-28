part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileUserSuccess extends ProfileState {}
class ProfileUserLoading extends ProfileState {}
