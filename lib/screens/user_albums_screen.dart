import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/user_album.dart';

import '../cubit/users_cubit.dart';
import '../cubit/user_albums_cubit.dart';

import '../widgets/user_details_album_preview.dart';

class UserAlbumsScreen extends StatelessWidget {
  const UserAlbumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;
    final user = BlocProvider.of<UsersCubit>(context).getUserInfoById(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.userName}\'s albums'),
      ),
      body: BlocBuilder<UserAlbumsCubit, UserAlbumsState>(
        builder: (context, state) {
          if (state is UserAlbumsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserAlbumsLoaded) {
            final List<UserAlbum> albums = state.loadedAlbums;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                itemCount: albums.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => UserDetailsAlbumPreview(
                  userAlbum: albums[index],
                  canTap: true,
                ),
              ),
            );
          }
          return const Center(
            child: Text('Couldn\'t load user albums...'),
          );
        },
      ),
    );
  }
}
