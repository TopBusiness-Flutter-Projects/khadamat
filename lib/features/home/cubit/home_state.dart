part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeError extends HomeState {}

//***************************************************
class SearchLoading extends HomeState {}

class SearchSuccess extends HomeState {}

class SearchFailure extends HomeState {}
//************************************************

class HomeChangeCurrentIndexTap extends HomeState {}

//************************************************
class ServicesBySubLoading extends HomeState {}

class ServicesBySubSuccess extends HomeState {}

class ServicesBySubFailure extends HomeState {}
