import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_comment.dart';

class CommentsApiProvider {
  final baseUrl = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<PostComment>> fetchPostComments(int postId) async {
    final url = Uri.parse('$baseUrl?postId=${postId.toString()}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> postCommentsJson = json.decode(response.body);
      return postCommentsJson
          .map((jsonData) => PostComment.fromMap(jsonData))
          .toList();
    } else {
      throw Exception('Could not fetch post comments data...');
    }
  }

  Future<int?> postNewComment(PostComment newComment) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(url, body: newComment.toJson());
    if (response.statusCode < 400) {
      return json.decode(response.body)['id'];
    } else {
      print(response.body);
      return null;
    }
  }
}
