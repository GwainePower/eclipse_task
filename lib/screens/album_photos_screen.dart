import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/album_photo.dart';
import '../cubit/user_albums_cubit.dart';
import '../cubit/album_photos_cubit.dart';
import '../widgets/album_photo_grid_item.dart';

class AlbumPhotosScreen extends StatelessWidget {
  const AlbumPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albumId = ModalRoute.of(context)!.settings.arguments as int;
    final album =
        BlocProvider.of<UserAlbumsCubit>(context).getAlbumById(albumId);
    BlocProvider.of<AlbumPhotosCubit>(context).getAlbumPhotos(albumId);
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: BlocBuilder<AlbumPhotosCubit, AlbumPhotosState>(
        builder: (context, state) {
          if (state is AlbumPhotosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AlbumPhotosFiltered) {
            final List<AlbumPhoto> photos = state.filteredPhotos;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                itemCount: photos.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) =>
                    AlbumPhotoGridItem(albumPhoto: photos[index]),
              ),
            );
          }
          return const Center(
            child: Text('Couldn\'t load album photos...'),
          );
        },
      ),
    );
  }
}
