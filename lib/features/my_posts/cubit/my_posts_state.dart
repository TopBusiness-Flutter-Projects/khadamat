part of 'my_posts_cubit.dart';

@immutable
abstract class MyPostsState {}

class MyPostsInitial extends MyPostsState {}
class MyPostsLoading extends MyPostsState {}
class MyPostsLoaded extends MyPostsState {}
class MyPostsError extends MyPostsState {}
