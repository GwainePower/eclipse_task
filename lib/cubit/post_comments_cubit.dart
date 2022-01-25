import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/post_comment.dart';

import '../data/services/repository.dart';

part 'post_comments_state.dart';

class PostCommentsCubit extends Cubit<PostCommentsState> {
  final Repository repository;

  PostCommentsCubit(this.repository) : super(PostCommentsInitial());

  List<PostComment> _postComments = [];

  Future<void> fetchPostComments(int postId) async {
    emit(PostCommentsLoading());
    try {
      final List<PostComment> _loadedPostComments =
          await repository.getPostComments(postId);
      _postComments = _loadedPostComments;
      emit(PostCommentsLoaded(loadedComments: _postComments));
    } catch (err) {
      emit(PostCommentsLoadError(message: 'Couldn\'t load user comments...'));
      print(err);
    }
  }

  void addNewComment(int postId, String email, String name, String body) async {
    emit(PostCommentsLoading());
    final PostComment newComment = PostComment(
      postId: postId,
      id: null,
      name: name,
      email: email,
      body: body,
    );
    final PostComment? newCommentWithId =
        await repository.postNewComment(newComment);
    if (newCommentWithId != null) {
      _postComments.add(newCommentWithId);
      print(_postComments.toString());
      emit(PostCommentsLoaded(loadedComments: _postComments));
    } else {
      emit(PostCommentsLoadError(message: 'Couldn\'t post comment...'));
    }
  }
}
