import 'package:flutter/material.dart';

import '../data/models/post_comment.dart';

class PostCommentsList extends StatelessWidget {
  const PostCommentsList({
    Key? key,
    required this.comments,
  }) : super(key: key);

  final List<PostComment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            children: [
              const Text('Email: '),
              Text(comments[index].email),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            width: MediaQuery.of(context).size.width,
            child: Text(
              comments[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(comments[index].body),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
