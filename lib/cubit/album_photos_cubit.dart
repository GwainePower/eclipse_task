import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/album_photo.dart';
import '../data/services/repository.dart';

part 'album_photos_state.dart';

class AlbumPhotosCubit extends Cubit<AlbumPhotosState> {
  final Repository _repository;

  AlbumPhotosCubit(this._repository) : super(AlbumPhotosInitial());

  List<AlbumPhoto> _albumPhotos = [];

  List<AlbumPhoto> _filteredPhotos = [];

  Future<void> getAlbumPhotos(int albumId) async {
    emit(AlbumPhotosLoading());
    try {
      final List<AlbumPhoto> loadedPhotos =
          await _repository.getAlbumPhotos(albumId);
      _filteredPhotos = loadedPhotos;
      emit(AlbumPhotosFiltered(filteredPhotos: _filteredPhotos));
    } catch (err) {
      emit(AlbumPhotosLoadError());
      print(err);
    }
  }

  Future<void> getAllPhotos() async {
    emit(AlbumPhotosLoading());
    try {
      final List<AlbumPhoto> loadedPhotos = await _repository.getAllPhotos();
      _albumPhotos = loadedPhotos;
      emit(AlbumPhotosLoaded(loadedPhotos: _albumPhotos));
    } catch (err) {
      emit(AlbumPhotosLoadError());
      print(err);
    }
  }

  AlbumPhoto? getPreview(int albumId) {
    if (_albumPhotos.isNotEmpty) {
      return _albumPhotos.firstWhere((photo) => photo.albumId == albumId);
    }
  }
}
