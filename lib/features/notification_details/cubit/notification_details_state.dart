part of 'notification_details_cubit.dart';

@immutable
abstract class NotificationDetailsState {}

class NotificationDetailsInitial extends NotificationDetailsState {}
class RateLoading extends NotificationDetailsState {}
class RateFailure extends NotificationDetailsState {}
class RateSuccess extends NotificationDetailsState {}
class AddFavouriteLoading extends NotificationDetailsState {}
class AddFavouriteFailure extends NotificationDetailsState {}
class AddFavouriteSuccess extends NotificationDetailsState {}
