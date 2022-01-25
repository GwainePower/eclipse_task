part of 'user_albums_cubit.dart';

@immutable
abstract class UserAlbumsState {}

class UserAlbumsInitial extends UserAlbumsState {}

class UserAlbumsLoading extends UserAlbumsState {}

class UserAlbumsLoaded extends UserAlbumsState {
  final List<UserAlbum> loadedAlbums;
  UserAlbumsLoaded({required this.loadedAlbums});
}

class UserAlbumsLoadError extends UserAlbumsState {}
