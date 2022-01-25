import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './constants/strings.dart';

import './helpers/custom_route.dart';

import './data/services/repository.dart';

import './cubit/users_cubit.dart';
import './cubit/user_posts_cubit.dart';
import './cubit/post_comments_cubit.dart';
import './cubit/album_photos_cubit.dart';
import './cubit/user_albums_cubit.dart';

import './screens/users_list_screen.dart';
import './screens/user_details_screen.dart';
import './screens/user_posts_screen.dart';
import './screens/user_albums_screen.dart';
import './screens/post_details_screen.dart';
import './screens/album_photos_screen.dart';
import './screens/photo_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (_) => UsersCubit(_repository),
        ),
        BlocProvider<UserPostsCubit>(
          create: (_) => UserPostsCubit(_repository),
        ),
        BlocProvider<PostCommentsCubit>(
          create: (_) => PostCommentsCubit(_repository),
        ),
        BlocProvider<AlbumPhotosCubit>(
          create: (_) => AlbumPhotosCubit(_repository),
        ),
        BlocProvider<UserAlbumsCubit>(
          create: (_) => UserAlbumsCubit(_repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eclipse task',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          primarySwatch: Colors.grey,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
          scaffoldBackgroundColor: Colors.black,
          cardColor: Colors.black,
          dividerColor: Colors.white,
          textTheme: const TextTheme(
            headline6: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
        ),
        home: const UsersListScreen(),
        initialRoute: '/',
        routes: {
          userDetailsRoute: (ctx) => const UserDetailsScreen(),
          userPostsRoute: (ctx) => const UserPostsScreen(),
          userAlbumsRoute: (ctx) => const UserAlbumsScreen(),
          postDetailsRoute: (ctx) => const PostDetailsScreen(),
          albumPhotosRoute: (ctx) => const AlbumPhotosScreen(),
          photoDetailsRoute: (ctx) => const PhotoDetailsScreen(),
        },
      ),
    );
  }
}
