import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/album_photo.dart';

class PhotosApiProvider {
  final baseUrl = 'https://jsonplaceholder.typicode.com/photos';

  Future<List<AlbumPhoto>> fetchAlbumPhotos(int albumId) async {
    final url = Uri.parse('$baseUrl?albumId=${albumId.toString()}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> albumPhotosJson = json.decode(response.body);
      return albumPhotosJson
          .map((jsonData) => AlbumPhoto.fromMap(jsonData))
          .toList();
    } else {
      throw Exception('Could not fetch album photos data...');
    }
  }

  Future<List<AlbumPhoto>> fetchAllPhotos() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> albumPhotosJson = json.decode(response.body);
      return albumPhotosJson
          .map((jsonData) => AlbumPhoto.fromMap(jsonData))
          .toList();
    } else {
      throw Exception('Could not fetch all photos data...');
    }
  }

  Future<AlbumPhoto> fetchOneAlbumPhoto(int albumId) async {
    final url = albumId == 1
        ? Uri.parse('$baseUrl/1')
        : Uri.parse('$baseUrl/${(albumId - 1) * 50 + 1}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic albumPhotoJson = json.decode(response.body);
      return AlbumPhoto.fromMap(albumPhotoJson);
    } else {
      throw Exception('Could not fetch album photo data...');
    }
  }
}
