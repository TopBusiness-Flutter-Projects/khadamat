part of 'nottification_cubit.dart';

@immutable
abstract class NottificationState {}

class NottificationInitial extends NottificationState {}
class NottificationLoading extends NottificationState {}
class NottificationSuccess extends NottificationState {}
class NottificationFailure extends NottificationState {}
