part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> loadedUsersList;
  UsersLoaded({required this.loadedUsersList});
}

class UsersLoadError extends UsersState {}
