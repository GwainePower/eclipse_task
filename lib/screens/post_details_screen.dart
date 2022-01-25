import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post_comment.dart';

import '../cubit/post_comments_cubit.dart';
import '../cubit/user_posts_cubit.dart';

import '../widgets/post_comments_list.dart';
import '../widgets/new_comment.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as int;
    final post = BlocProvider.of<UserPostsCubit>(context).getPostById(postId);
    // BlocProvider.of<PostCommentsCubit>(context).fetchPostComments(postId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    post.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(),
                  Text(
                    post.body,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Comments:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  BlocBuilder<PostCommentsCubit, PostCommentsState>(
                    builder: (context, state) {
                      bool commentsLoaded = state is PostCommentsLoaded;
                      return IconButton(
                        onPressed: () => commentsLoaded
                            ? showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {},
                                  child: NewComment(postId: postId),
                                ),
                              )
                            : null,
                        icon: Icon(
                          Icons.add,
                          color: commentsLoaded ? Colors.white : Colors.grey,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.46,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<PostCommentsCubit, PostCommentsState>(
                    builder: (context, state) {
                      if (state is PostCommentsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is PostCommentsLoaded) {
                        final List<PostComment> postComments =
                            state.loadedComments;
                        return PostCommentsList(comments: postComments);
                      }
                      return const Center(
                        child: Text('Couldn\'t load post comments...'),
                      );
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
