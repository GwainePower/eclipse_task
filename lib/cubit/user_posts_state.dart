part of 'user_posts_cubit.dart';

@immutable
abstract class UserPostsState {}

class UserPostsInitial extends UserPostsState {}

class UserPostsLoading extends UserPostsState {}

class UserPostsLoaded extends UserPostsState {
  final List<UserPost> loadedUserPosts;
  UserPostsLoaded({required this.loadedUserPosts});
}

class UserPostsLoadError extends UserPostsState {}
