



import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';

abstract interface class BookmarkRepository {

  Future<List<PostModel>> getMyBookmarks(bool isRefresh);

  Future<bool> postBookmark(PostEntity bookmark);

  Future<bool> deletBookmark(String bookmarkId);

}