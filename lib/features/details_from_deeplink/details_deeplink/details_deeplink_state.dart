part of 'details_deeplink_cubit.dart';

@immutable
abstract class DetailsDeeplinkState {}

class DetailsDeeplinkInitial extends DetailsDeeplinkState {}
class getServiceDetailsFailure extends DetailsDeeplinkState {}
class getServiceDetailsSuccess extends DetailsDeeplinkState {}
