part of 'my_posts_cubit.dart';

@immutable
abstract class MyPostsState {}

class MyPostsInitial extends MyPostsState {}
class MyPostsLoading extends MyPostsState {}
class MyPostsLoaded extends MyPostsState {}
class MyPostsError extends MyPostsState {}
//**************************************
class MyPostsSearchError extends MyPostsState {}
class MyPostsSearchSuccess extends MyPostsState {}
class MyPostsSearchLoading extends MyPostsState {}
//**************************************************
// class EditServiceLoading extends MyPostsState {}
// class EditServiceSuccess extends MyPostsState {}
// class EditServiceFailure extends MyPostsState {}
