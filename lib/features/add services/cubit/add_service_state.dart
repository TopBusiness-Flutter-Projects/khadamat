part of 'add_service_cubit.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}
class logoImageLoading extends AddServiceState {}
class logoImageSuccess extends AddServiceState {}
class logoImageFailure extends AddServiceState {}
//******************************************************
class ServiceImageLoading extends AddServiceState {}
class ServiceImageSuccess extends AddServiceState {}
class ServiceImageFailure extends AddServiceState {}
//******************************************************
class StoreServiceLoading  extends AddServiceState {}
class StoreServiceSuccess  extends AddServiceState {}
class StoreServiceFailure extends AddServiceState {}
//******************************************************
class ClearService extends AddServiceState {}
//*******************************************************
class CategoriesLoading extends AddServiceState {}
class CategoriesSuccess extends AddServiceState {}
class CategoriesFailure extends AddServiceState {}
//**********************************************************
class ChangeCategoriesState extends AddServiceState {}
class ChangeCityState extends AddServiceState {}
class RemoveImageState extends AddServiceState {}
//*******************************************************
class CitiesLoading extends AddServiceState {}
class CitiesSuccess extends AddServiceState {}
class CitiesFailure extends AddServiceState {}
//**************************************************
class placeState extends AddServiceState{}
//**************************************************************
class EditServiceFailure extends AddServiceState{}
class EditServiceSuccess extends AddServiceState{}



class MinimizedOrMaximized extends AddServiceState{}
//**********************************************************************
class GoogleMapsInitial extends AddServiceState {}
class LocationPermissionSuccess extends AddServiceState {}
class LocationPermissionFailed extends AddServiceState {}

class NewLocationSelected extends AddServiceState {}
class CurrentAddressState extends AddServiceState {}
class CameraMoveState extends AddServiceState {}

class pickImagesState extends AddServiceState {}