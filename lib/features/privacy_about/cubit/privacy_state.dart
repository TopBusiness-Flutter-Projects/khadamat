part of 'privacy_cubit.dart';

@immutable
abstract class PrivacyState {}

class PrivacyInitial extends PrivacyState {}
class PrivacyLoading extends PrivacyState {}
class PrivacySuccess extends PrivacyState {}
class PrivacyError extends PrivacyState {}
