part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}
class Favoriteloaded extends FavoriteState {}
class FavoriteError extends FavoriteState {}
//****************************************************
class FavoriteSearchError extends FavoriteState {}
class FavoriteSearchSuccess extends FavoriteState {}
class FavoriteSearchLoading extends FavoriteState {}
