import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/user/user.dart';

import '../data/services/repository.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final Repository repository;

  UsersCubit(this.repository) : super(UsersInitial());

  List<User> _users = [];

  Future<void> fetchUsers(bool needsUpdate) async {
    emit(UsersLoading());
    try {
      final List<User> _loadedUsersList =
          await repository.getUsersList(needsUpdate);
      _users = _loadedUsersList;
      emit(UsersLoaded(loadedUsersList: _users));
      // print(_loadedUsersList.toString());
    } catch (err) {
      emit(UsersLoadError());
      print(err);
    }
  }

  User getUserInfoById(int id) {
    return _users.firstWhere((user) => id == user.id);
  }
}
