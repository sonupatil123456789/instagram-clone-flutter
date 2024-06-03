import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebasePostCollection.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/UserProfileScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';

class UserProfileScreenRemoteDataSourceImpl
    implements UserProfileScreenRemoteDataSource {
  FirebasePostCollection postCollection;
  PostModel postModel;

  UserProfileScreenRemoteDataSourceImpl(
    this.postCollection,
    this.postModel,
  );

  late QuerySnapshot? querySnapshot;
  List<PostModel> myPosts = [];
  bool isFetched = false;

  FirebaseAuth get auth => postCollection.firebaseAuthInstance;

  @override
  Future<List<PostModel>> getMyPostPost(isRefresh) async {
    final userId = auth.currentUser?.uid;
    try {
      if (!isFetched || isRefresh) {
        myPosts.clear();
        querySnapshot =
            await postCollection.getUserSpecificPosts(userId.toString());

        querySnapshot?.docs.forEach((element) {
          myPosts.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
        });

        CoustomLog.coustomLogData("getMyPostPost", myPosts.length.toString());
        isFetched = true;
        return myPosts;
      } else {
        return myPosts;
      }
    } catch (error, stack) {
      CoustomLog.coustomLogError("getMyPostPost", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> deletUserPost(String postId) async {
    try {
      querySnapshot = await postCollection.deletPostDocument(postId);
      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("deletUserPost", error, stack);
      rethrow;
    }
  }
}
