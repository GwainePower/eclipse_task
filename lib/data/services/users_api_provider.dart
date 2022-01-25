import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user/user.dart';

class UsersApiProvider {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  Future<List<User>> fetchUsers() async {
    final response = await http.get(url);
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = json.decode(response.body);
      return usersJson.map((jsonData) => User.fromMap(jsonData)).toList();
    } else {
      throw Exception('Could not fetch user data...');
    }
  }
}
