import 'package:eclipse_task/constants/strings.dart';
import 'package:eclipse_task/cubit/post_comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/user_post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    Key? key,
    required this.userPost,
  }) : super(key: key);

  final UserPost userPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: InkWell(
            onTap: () {
              BlocProvider.of<PostCommentsCubit>(context)
                  .fetchPostComments(userPost.id);
              Navigator.of(context)
                  .pushNamed(postDetailsRoute, arguments: userPost.id);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Text(
                    userPost.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(userPost.body),
                ],
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
