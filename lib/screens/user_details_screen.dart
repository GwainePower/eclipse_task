import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/strings.dart';

import '../cubit/users_cubit.dart';
import '../cubit/user_posts_cubit.dart';
import '../cubit/user_albums_cubit.dart';

import '../widgets/user_details_album_preview.dart';
import '../widgets/user_details_post_preview.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final userId = ModalRoute.of(context)!.settings.arguments as int;
    final user = BlocProvider.of<UsersCubit>(context).getUserInfoById(userId);
    BlocProvider.of<UserPostsCubit>(context).fetchUserPosts(userId);
    BlocProvider.of<UserAlbumsCubit>(context).getUserAlbums(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.userName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: deviceSize.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Email:'),
                  Text(user.email),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: deviceSize.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Phone number:'),
                  Text(user.phone),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                children: [
                  Text(user.company.name),
                  Text(user.company.bs),
                  Text(user.company.catchPhrase),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                  '${user.address.city}, ${user.address.street}, ${user.address.suite}, ${user.address.zipcode}'),
            ),
            const Divider(thickness: 0.5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: deviceSize.width,
              child: const Text(
                'User posts:',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(userPostsRoute, arguments: userId),
                child: BlocBuilder<UserPostsCubit, UserPostsState>(
                  builder: (context, state) {
                    if (state is UserPostsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is UserPostsLoaded) {
                      final loadedPosts =
                          state.loadedUserPosts.reversed.toList();
                      return Column(
                        children: [
                          UserDetailsPostPreview(post: loadedPosts[0]),
                          UserDetailsPostPreview(post: loadedPosts[1]),
                          UserDetailsPostPreview(post: loadedPosts[2]),
                        ],
                      );
                    }
                    if (state is UserPostsLoadError) {
                      return const Center(
                        child: Text('Could not load user posts'),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: deviceSize.width,
              child: const Text(
                'User albums:',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(userAlbumsRoute, arguments: userId),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<UserAlbumsCubit, UserAlbumsState>(
                    builder: (context, state) {
                      if (state is UserAlbumsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is UserAlbumsLoaded) {
                        final loadedAlbums =
                            state.loadedAlbums.reversed.toList();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              UserDetailsAlbumPreview(
                                userAlbum: loadedAlbums[0],
                              ),
                              UserDetailsAlbumPreview(
                                userAlbum: loadedAlbums[1],
                              ),
                              UserDetailsAlbumPreview(
                                userAlbum: loadedAlbums[2],
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is UserAlbumsLoadError) {
                        return const Center(
                          child: Text('Could not load user albums'),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
