part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsServicesLoading extends PostsState {}

class PostsServicesLoaded extends PostsState {}

class PostsServicesError extends PostsState {}

//*******************************************
class searchServicesError extends PostsState {}

class searchServicesLoading extends PostsState {}

class searchServicesSuccess extends PostsState {}

class SubServicesLoading extends PostsState {}

class SubServicesLoaded extends PostsState {}

class SubServicesError extends PostsState {}
