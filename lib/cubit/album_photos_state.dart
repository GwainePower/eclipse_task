part of 'album_photos_cubit.dart';

@immutable
abstract class AlbumPhotosState {}

class AlbumPhotosInitial extends AlbumPhotosState {}

class AlbumPhotosLoading extends AlbumPhotosState {}

class AlbumPhotosLoaded extends AlbumPhotosState {
  final List<AlbumPhoto> loadedPhotos;
  AlbumPhotosLoaded({required this.loadedPhotos});
}

class AlbumPhotosFiltered extends AlbumPhotosState {
  final List<AlbumPhoto> filteredPhotos;
  AlbumPhotosFiltered({required this.filteredPhotos});
}

class AlbumPhotosLoadError extends AlbumPhotosState {}
