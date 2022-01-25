import 'dart:convert';

class UserAlbum {
  final int userId;
  final int id;
  final String title;

  UserAlbum({
    required this.userId,
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory UserAlbum.fromMap(Map<String, dynamic> map) {
    return UserAlbum(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAlbum.fromJson(String source) =>
      UserAlbum.fromMap(json.decode(source));
}
