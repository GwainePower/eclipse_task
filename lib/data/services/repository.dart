import '../../helpers/db_helper.dart';

import '../models/user/user.dart';
import '../models/user/address.dart';
import '../models/user/company.dart';
import '../models/user_post.dart';
import '../models/user_album.dart';
import '../models/album_photo.dart';
import '../models/post_comment.dart';

import './users_api_provider.dart';
import './posts_api_provider.dart';
import './albums_api_provider.dart';
import './photos_api_provider.dart';
import './comments_api_provider.dart';

class Repository {
  final UsersApiProvider _usersApiProvider = UsersApiProvider();
  final PostsApiProvider _postsApiProvider = PostsApiProvider();
  final AlbumsApiProvider _albumsApiProvider = AlbumsApiProvider();
  final PhotosApiProvider _photosApiProvider = PhotosApiProvider();
  final CommentsApiProvider _commentsApiProvider = CommentsApiProvider();

  // Users
  Future<List<User>> getUsersList(bool needsUpdate) async {
    final dbData = await DBHelper.getData('users');
    if (dbData.isNotEmpty && !needsUpdate) {
      print('got users from db');
      return dbData
          .map(
            (user) => User(
              id: user['id'],
              name: user['name'],
              userName: user['username'],
              email: user['email'],
              address: UserAddress(
                  street: user['street'],
                  suite: user['suite'],
                  city: user['city'],
                  zipcode: user['zipcode']),
              phone: user['phone'],
              website: user['website'],
              company: Company(
                name: user['companyName'],
                catchPhrase: user['catchPhrase'],
                bs: user['bs'],
              ),
            ),
          )
          .toList();
    }
    final List<User> internetUsers = await _usersApiProvider.fetchUsers();
    for (int i = 0; i < internetUsers.length; i++) {
      DBHelper.insertData('users', {
        'id': internetUsers[i].id,
        'name': internetUsers[i].name,
        'username': internetUsers[i].userName,
        'email': internetUsers[i].email,
        'street': internetUsers[i].address.street,
        'suite': internetUsers[i].address.suite,
        'city': internetUsers[i].address.city,
        'zipcode': internetUsers[i].address.zipcode,
        'phone': internetUsers[i].phone,
        'website': internetUsers[i].website,
        'companyName': internetUsers[i].company.name,
        'catchPhrase': internetUsers[i].company.catchPhrase,
        'bs': internetUsers[i].company.bs,
      });
    }
    print('got users from internet');
    return internetUsers;
  }

  // User posts
  Future<List<UserPost>> getUserPosts(int userId) async {
    final dbData = await DBHelper.getDataById('user_posts', 'userId', userId);
    if (dbData.isNotEmpty) {
      print('got user posts from db');
      return dbData
          .map(
            (userPost) => UserPost(
              userId: userPost['userId'],
              id: userPost['id'],
              title: userPost['title'],
              body: userPost['body'],
            ),
          )
          .toList();
    }
    final List<UserPost> internetPosts =
        await _postsApiProvider.fetchUserPosts(userId);
    for (int i = 0; i < internetPosts.length; i++) {
      DBHelper.insertData('user_posts', {
        'id': internetPosts[i].id,
        'userId': internetPosts[i].userId,
        'title': internetPosts[i].title,
        'body': internetPosts[i].body,
      });
    }
    print('got user posts from internet');
    return internetPosts;
  }

  // User albums
  Future<List<UserAlbum>> getUserAlbums(int userId) async {
    final dbData = await DBHelper.getDataById('user_albums', 'userId', userId);
    if (dbData.isNotEmpty) {
      print('got user albums from db');
      return dbData
          .map(
            (userAlbums) => UserAlbum(
              userId: userAlbums['userId'],
              id: userAlbums['id'],
              title: userAlbums['title'],
            ),
          )
          .toList();
    }
    final List<UserAlbum> internetAlbums =
        await _albumsApiProvider.fetchUserAlbums(userId);
    for (int i = 0; i < internetAlbums.length; i++) {
      DBHelper.insertData('user_albums', {
        'id': internetAlbums[i].id,
        'userId': internetAlbums[i].userId,
        'title': internetAlbums[i].title,
      });
    }
    print('got user albums from internet');
    return internetAlbums;
  }

  // Album photos
  Future<List<AlbumPhoto>> getAllPhotos() async {
    final dbData = await DBHelper.getData('album_photos');
    if (dbData.isNotEmpty) {
      print('got photos from db');
      return dbData
          .map((albumPhotos) => AlbumPhoto(
              albumId: albumPhotos['albumId'],
              id: albumPhotos['id'],
              title: albumPhotos['title'],
              url: albumPhotos['url'],
              thumbnailUrl: albumPhotos['thumbnailUrl']))
          .toList();
    }
    final List<AlbumPhoto> internetPhotos =
        await _photosApiProvider.fetchAllPhotos();
    for (int i = 0; i < internetPhotos.length; i++) {
      DBHelper.insertData('album_photos', {
        'id': internetPhotos[i].id,
        'albumId': internetPhotos[i].albumId,
        'title': internetPhotos[i].title,
        'url': internetPhotos[i].url,
        'thumbnailUrl': internetPhotos[i].thumbnailUrl,
      });
    }
    print('got photos from internet');
    return internetPhotos;
  }

  Future<List<AlbumPhoto>> getAlbumPhotos(int albumId) async {
    final dbData =
        await DBHelper.getDataById('album_photos', 'albumId', albumId);
    if (dbData.isNotEmpty) {
      print('got photos from db');
      return dbData
          .map((albumPhotos) => AlbumPhoto(
              albumId: albumPhotos['albumId'],
              id: albumPhotos['id'],
              title: albumPhotos['title'],
              url: albumPhotos['url'],
              thumbnailUrl: albumPhotos['thumbnailUrl']))
          .toList();
    }
    final List<AlbumPhoto> internetPhotos =
        await _photosApiProvider.fetchAlbumPhotos(albumId);
    for (int i = 0; i < internetPhotos.length; i++) {
      DBHelper.insertData('album_photos', {
        'id': internetPhotos[i].id,
        'albumId': internetPhotos[i].albumId,
        'title': internetPhotos[i].title,
        'url': internetPhotos[i].url,
        'thumbnailUrl': internetPhotos[i].thumbnailUrl,
      });
    }
    print('got photos from internet');
    return internetPhotos;
  }

  // Post comments
  Future<List<PostComment>> getPostComments(int postId) async {
    final dbData =
        await DBHelper.getDataById('post_comments', 'postId', postId);
    if (dbData.isNotEmpty) {
      print('got post comments from db');
      return dbData
          .map(
            (postComment) => PostComment(
              id: postComment['id'],
              postId: postComment['postId'],
              name: postComment['name'],
              email: postComment['email'],
              body: postComment['body'],
            ),
          )
          .toList();
    }
    final List<PostComment> internetPostComments =
        await _commentsApiProvider.fetchPostComments(postId);
    for (int i = 0; i < internetPostComments.length; i++) {
      DBHelper.insertData('post_comments', {
        'id': internetPostComments[i].id!,
        'postId': internetPostComments[i].postId,
        'name': internetPostComments[i].name,
        'email': internetPostComments[i].email,
        'body': internetPostComments[i].body,
      });
    }
    print('got post comments from internet');
    return internetPostComments;
  }

  Future<PostComment?> postNewComment(PostComment newComment) =>
      _commentsApiProvider.postNewComment(newComment).then((commentId) {
        if (commentId != null) {
          DBHelper.insertData('post_comments', {
            'id': commentId,
            'postId': newComment.postId,
            'name': newComment.name,
            'email': newComment.email,
            'body': newComment.body,
          });
          print('Comment post success');
          return PostComment(
              postId: newComment.postId,
              id: commentId,
              name: newComment.name,
              email: newComment.email,
              body: newComment.body);
        }
        return null;
      });
}
