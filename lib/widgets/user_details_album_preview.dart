import 'package:eclipse_task/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/user_album.dart';

import '../cubit/album_photos_cubit.dart';

class UserDetailsAlbumPreview extends StatelessWidget {
  const UserDetailsAlbumPreview({
    Key? key,
    required this.userAlbum,
    this.canTap = false,
  }) : super(key: key);

  final UserAlbum userAlbum;
  final bool canTap;

  @override
  Widget build(BuildContext context) {
    final preview =
        BlocProvider.of<AlbumPhotosCubit>(context).getPreview(userAlbum.id);
    return InkWell(
      onTap: canTap
          ? () => Navigator.of(context)
              .pushNamed(albumPhotosRoute, arguments: userAlbum.id)
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  preview!.thumbnailUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: Text(
                userAlbum.title,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
