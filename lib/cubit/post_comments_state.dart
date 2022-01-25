part of 'post_comments_cubit.dart';

@immutable
abstract class PostCommentsState {}

class PostCommentsInitial extends PostCommentsState {}

class PostCommentsLoading extends PostCommentsState {}

class PostCommentsLoaded extends PostCommentsState {
  final List<PostComment> loadedComments;
  PostCommentsLoaded({required this.loadedComments});
}

class PostCommentsLoadError extends PostCommentsState {
  final String message;
  PostCommentsLoadError({required this.message});
}
