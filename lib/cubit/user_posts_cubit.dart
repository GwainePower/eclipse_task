import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/user_post.dart';

import '../data/services/repository.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  final Repository repository;

  UserPostsCubit(this.repository) : super(UserPostsInitial());

  List<UserPost> _userPosts = [];

  Future<void> fetchUserPosts(int userId) async {
    emit(UserPostsLoading());
    try {
      final List<UserPost> _loadedUserPosts =
          await repository.getUserPosts(userId);
      _userPosts = _loadedUserPosts;
      emit(UserPostsLoaded(loadedUserPosts: _userPosts));
    } catch (err) {
      emit(UserPostsLoadError());
      print(err);
    }
  }

  UserPost getPostById(int id) {
    return _userPosts.firstWhere((post) => id == post.id);
  }
}
