import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/album_photos_cubit.dart';
import '../cubit/users_cubit.dart';

import '../widgets/users_list.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersCubit>(context).fetchUsers(false);
    BlocProvider.of<AlbumPhotosCubit>(context).getAllPhotos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: RefreshIndicator(
        onRefresh: () => BlocProvider.of<UsersCubit>(context).fetchUsers(true),
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UsersLoaded) {
              return UsersList(users: state.loadedUsersList);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
