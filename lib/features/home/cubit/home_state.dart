part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {}
class HomeError extends HomeState {}

class HomeChangeCurrentIndexTap extends HomeState {}


