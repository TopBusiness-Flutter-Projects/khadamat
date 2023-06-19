part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}
class AddingRateLoading extends DetailsState {}
class AddingRateSuccess extends DetailsState {}
class AddingRateFailure extends DetailsState {}
//********************************************************
class AddingFavouriteFailure extends DetailsState {}
class AddingFavouriteSuccess extends DetailsState {}
class AddingFavouriteLoading extends DetailsState {}
