import 'package:eclipse_task/constants/strings.dart';
import 'package:flutter/material.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({
    Key? key,
    required this.id,
    required this.userName,
    required this.fullName,
  }) : super(key: key);

  final int id;
  final String userName;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        userDetailsRoute,
        arguments: id,
      ),
      child: ListTile(
        leading: Text(
          userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: Text(
          fullName,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
