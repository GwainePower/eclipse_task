import 'package:eclipse_task/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:eclipse_task/data/models/album_photo.dart';

class AlbumPhotoGridItem extends StatelessWidget {
  const AlbumPhotoGridItem({
    Key? key,
    required this.albumPhoto,
  }) : super(key: key);

  final AlbumPhoto albumPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(photoDetailsRoute, arguments: albumPhoto),
      child: GridTile(
        child: Hero(
          tag: albumPhoto.id,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
            ),
            child: Image.network(albumPhoto.url),
          ),
        ),
      ),
    );
  }
}
