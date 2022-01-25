import 'dart:convert';

class PostComment {
  final int postId;
  int? id;
  final String name;
  final String email;
  final String body;

  PostComment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      postId: map['postId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostComment.fromJson(String source) =>
      PostComment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostComment(postId: $postId, id: $id, name: $name, email: $email, body: $body)';
  }
}
