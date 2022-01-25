import 'package:flutter/material.dart';

import 'package:eclipse_task/data/models/user_post.dart';

class UserDetailsPostPreview extends StatelessWidget {
  const UserDetailsPostPreview({
    Key? key,
    required this.post,
  }) : super(key: key);

  final UserPost post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            post.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${post.body.substring(0, post.body.indexOf('\n'))}...',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
