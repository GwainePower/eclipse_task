import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_album.dart';

class AlbumsApiProvider {
  final baseUrl = 'https://jsonplaceholder.typicode.com/albums?userId=';

  Future<List<UserAlbum>> fetchUserAlbums(int userId) async {
    final url = Uri.parse(baseUrl + userId.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> userAlbumsJson = json.decode(response.body);
      return userAlbumsJson
          .map((jsonData) => UserAlbum.fromMap(jsonData))
          .toList();
    } else {
      throw Exception('Could not fetch user albums data...');
    }
  }
}
