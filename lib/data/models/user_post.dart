import 'dart:convert';

class UserPost {
  final int userId;
  final int id;
  final String title;
  final String body;

  UserPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory UserPost.fromMap(Map<String, dynamic> map) {
    return UserPost(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPost.fromJson(String source) =>
      UserPost.fromMap(json.decode(source));
}
