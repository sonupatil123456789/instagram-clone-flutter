
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';

abstract interface class BookmarkRemoteDataSource {

  Future<List<PostModel>> getMyBookmarks(bool isRefresh);

  Future<bool> postBookmark(PostModel bookmark);

  Future<bool> deletBookmark(String bookmarkId);

}
