import 'package:flutter/material.dart';

import '../data/models/album_photo.dart';

class PhotoDetailsScreen extends StatelessWidget {
  const PhotoDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumPhoto photo =
        ModalRoute.of(context)!.settings.arguments as AlbumPhoto;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
      ),
      body: Column(
        children: [
          Hero(
            tag: photo.id,
            child: Image.network(
              photo.url,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              photo.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
