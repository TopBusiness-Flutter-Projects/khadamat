part of 'google_maps_cubit.dart';

@immutable
abstract class GoogleMapsState {}

class GoogleMapsInitial extends GoogleMapsState {}
class LocationPermissionSuccess extends GoogleMapsState {}
class LocationPermissionFailed extends GoogleMapsState {}
//***************************************************************
class NewLocationSelected extends GoogleMapsState {}
class CurrentAddressState extends GoogleMapsState {}
