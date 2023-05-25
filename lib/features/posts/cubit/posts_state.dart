part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsServicesLoading extends PostsState {}
class PostsServicesLoaded extends PostsState {}
class PostsServicesError extends PostsState {}
