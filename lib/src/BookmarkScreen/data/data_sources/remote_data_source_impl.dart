import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseBookmarkCollection.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/BookmarkScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  PostModel postModel;
  FirebaseBookmarkCollection bookmarkCollection;

  BookmarkRemoteDataSourceImpl(
    this.postModel,
    this.bookmarkCollection,
  );

  late QuerySnapshot? querySnapshot;
  List<PostModel> bookmark = [];
  bool isFetched = false;

  FirebaseAuth get auth => bookmarkCollection.firebaseAuthInstance;

  @override
  Future<List<PostModel>> getMyBookmarks(isRefresh) async {
    final userId = auth.currentUser?.uid;

    try {
      if (!isFetched || isRefresh) {
        bookmark.clear();
        querySnapshot =
            await bookmarkCollection.getALlUserBookmarkDocument(userId!);
        querySnapshot?.docs.forEach((element) {
          bookmark
              .add(PostModel.fromMap(element.data() as Map<String, dynamic>));
        });
        CoustomLog.coustomLogData("getMyBookmarks", bookmark.length);
        isFetched = true;
        return bookmark;
      } else {
        return bookmark;
      }
    } catch (error, stack) {
      CoustomLog.coustomLogError("getMyBookmarks", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> deletBookmark(String bookmarkId) async {
    final userId = auth.currentUser?.uid;
    try {
      await bookmarkCollection.deletBookmarkDocument(userId!, bookmarkId);
      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("deletBookmark", error, stack);
      rethrow;
    }
  }
  
  @override
  Future<bool> postBookmark(PostModel bookmarkData)async {
     final userId = auth.currentUser?.uid;
    //  final bookmarkId = Uuid().v4();
    try {
      CoustomLog.coustomLogData("postBookmark", bookmarkData);
      await bookmarkCollection.setALlUserBookmarkDocument(userId!, bookmarkData.postId,bookmarkData.toMap());
      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("postBookmark", error, stack);
      rethrow;
    }
  }
}





