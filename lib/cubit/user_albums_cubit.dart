import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/user_album.dart';
import '../data/services/repository.dart';

part 'user_albums_state.dart';

class UserAlbumsCubit extends Cubit<UserAlbumsState> {
  final Repository _repository;

  UserAlbumsCubit(
    this._repository,
  ) : super(UserAlbumsInitial());

  List<UserAlbum> _userAlbums = [];

  Future<void> getUserAlbums(int userId) async {
    emit(UserAlbumsLoading());
    try {
      final List<UserAlbum> loadedAlbums =
          await _repository.getUserAlbums(userId);
      _userAlbums = loadedAlbums;
      emit(UserAlbumsLoaded(loadedAlbums: _userAlbums));
    } catch (err) {
      emit(UserAlbumsLoadError());
      print(err);
    }
  }

  UserAlbum getAlbumById(int id) {
    return _userAlbums.firstWhere((album) => id == album.id);
  }
}
