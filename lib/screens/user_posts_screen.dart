import 'package:eclipse_task/cubit/user_posts_cubit.dart';
import 'package:eclipse_task/data/models/user_post.dart';
import 'package:eclipse_task/widgets/post_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/users_cubit.dart';

class UserPostsScreen extends StatelessWidget {
  const UserPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;
    final user = BlocProvider.of<UsersCubit>(context).getUserInfoById(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.userName}\'s posts'),
      ),
      body: BlocBuilder<UserPostsCubit, UserPostsState>(
        builder: (context, state) {
          if (state is UserPostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserPostsLoaded) {
            final List<UserPost> userPosts =
                state.loadedUserPosts.reversed.toList();
            return ListView.builder(
              itemCount: userPosts.length,
              itemBuilder: (context, index) =>
                  PostListItem(userPost: userPosts[index]),
            );
          }
          return const Center(
            child: Text('Couldn\'t load user posts...'),
          );
        },
      ),
    );
  }
}
