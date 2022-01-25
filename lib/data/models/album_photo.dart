import 'dart:convert';

class AlbumPhoto {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  AlbumPhoto({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory AlbumPhoto.fromMap(Map<String, dynamic> map) {
    return AlbumPhoto(
      albumId: map['albumId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumPhoto.fromJson(String source) =>
      AlbumPhoto.fromMap(json.decode(source));
}
