part of 'details_deeplink_cubit.dart';

@immutable
abstract class DetailsDeeplinkState {}

class DetailsDeeplinkInitial extends DetailsDeeplinkState {}
class getServiceDetailsFailure extends DetailsDeeplinkState {}
class getServiceDetailsSuccess extends DetailsDeeplinkState {}
class AddingFavouriteLoadingState extends DetailsDeeplinkState {}
class AddingFavouriteFailureState extends DetailsDeeplinkState {}
class AddingFavouriteSuccessState extends DetailsDeeplinkState {}
class AddingRateLoadingState extends DetailsDeeplinkState {}
class AddingRateFailureState extends DetailsDeeplinkState {}
class AddingRateSuccessState extends DetailsDeeplinkState {}
class LoadingServiceDetails extends DetailsDeeplinkState {}
