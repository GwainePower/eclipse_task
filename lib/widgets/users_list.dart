import 'package:flutter/material.dart';

import '../data/models/user/user.dart';

import './users_list_item.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => Column(
        children: [
          UsersListItem(
              id: users[index].id,
              userName: users[index].userName,
              fullName: users[index].name),
          const Divider(),
        ],
      ),
    );
  }
}
