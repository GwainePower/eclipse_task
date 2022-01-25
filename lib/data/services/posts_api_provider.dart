import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_post.dart';

class PostsApiProvider {
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts?userId=';

  Future<List<UserPost>> fetchUserPosts(int userId) async {
    final url = Uri.parse(baseUrl + userId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> userPostsJson = json.decode(response.body);
      return userPostsJson
          .map((jsonData) => UserPost.fromMap(jsonData))
          .toList();
    } else {
      throw Exception('Could not fetch user posts data...');
    }
  }
}
