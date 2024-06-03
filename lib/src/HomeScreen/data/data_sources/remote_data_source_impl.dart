import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebasePostCollection.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/CommentModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/LikeModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/HomeScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'package:uuid/uuid.dart';

class HomeScreenRemoteDataSourceImpl implements HomeScreenRemoteDataSource {
  FirebasePostCollection postCollection;
  PostModel postModel;

  HomeScreenRemoteDataSourceImpl(
    this.postCollection,
    this.postModel,
  );

  late QuerySnapshot? querySnapshot;
  List<PostModel> posts = [];
  bool isFetched = false;

  FirebaseAuth get auth => postCollection.firebaseAuthInstance;

  @override
  Future<List<PostModel>> getAllFriendsPost(
      List<FollowModel> following, isRefresh) async {
    try {
      if (!isFetched || isRefresh) {
        List<String> followingUserUuid =
            following.map((following) => following.uuid.toString()).toList();
        posts.clear();
        for (String userId in followingUserUuid) {
          querySnapshot =
              await postCollection.getUserSpecificPosts(userId.toString());

          querySnapshot?.docs.forEach((element) {
            posts
                .add(PostModel.fromMap(element.data() as Map<String, dynamic>));
          });
        }
        CoustomLog.coustomLogData("getAllFriendsPost", posts.length);
        isFetched = true;
        return posts;
      } else {
        return posts;
      }
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllFriendsPost", error, stack);
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getAllPost(isRefresh) async {
    try {
      if (!isFetched || isRefresh) {
        posts.clear();
        QuerySnapshot querysnapshot = await postCollection.getAllPostDocument();
        for (var element in querysnapshot.docs) {
          posts.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
        }
        CoustomLog.coustomLogData("getAllFriendsPost", posts);
        isFetched = true;
        return posts;
      } else {
        return posts;
      }
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllFriendsPost", error, stack);
      rethrow;
    }
  }

  @override
  Future<LikeModel> likePost(String postId, LikeModel like) async {
    try {
      QuerySnapshot querySnapshot = await postCollection.queryPostArrey(
          "likes", postId.toString(), like.toMap());

      if (querySnapshot.docs.isNotEmpty) {
        await postCollection.removePostArrey(
            postId.toString(), "likes", like.toMap());
      
      } else {
        await postCollection.updatePostArrey(
            postId.toString(), "likes", like.toMap());
       
      }
      return like;
    } catch (error, stack) {
      CoustomLog.coustomLogError("likePost", error, stack);
      rethrow;
    }
  }

  @override
  Stream<List<PostModel>> getAllFriendsPostStream(
      List<FollowModel> following, bool isRefresh) {
    try {
      List<String> followingUserUuid =
          following.map((following) => following.uuid.toString()).toList();

      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshotStream =postCollection.getUserSpecificPostsStream(followingUserUuid);
      Stream<List<PostModel>> userPostStream = querySnapshotStream.map(
          (event) =>
              event.docs.map((e) => PostModel.fromMap(e.data())).toList());

      CoustomLog.coustomLogData("getAllFriendsPostStream", userPostStream.length);
      return userPostStream;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllFriendsPostStream", error, stack);
      rethrow;
    }
  }

  @override
  Stream<List<PostModel>> getAllPostStream(bool isRefresh) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshotStream =
          postCollection.getAllPostDocumentStream();
      Stream<List<PostModel>> userPostStream = querySnapshotStream.map(
          (event) =>
              event.docs.map((e) => PostModel.fromMap(e.data())).toList());

      CoustomLog.coustomLogData("getAllPostStream", userPostStream.length);
      return userPostStream;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllPostStream", error, stack);
      rethrow;
    }
  }

  @override
  Stream<List<CommentsModel>> getAllPostCommentsStream(String postId) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshotStream =
          postCollection.getUserPostCommentsStream(postId);
      Stream<List<CommentsModel>> userCommentsStream = querySnapshotStream.map(
          (event) =>
              event.docs.map((e) => CommentsModel.fromMap(e.data())).toList());
      CoustomLog.coustomLogData("postCommentReplay", userCommentsStream.length);
      return userCommentsStream;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllPostCommentsStream", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> postCommentReplay(String postId, CommentsModel comment) async {
    try {
      final commentId = const Uuid().v4();

      final uploadComment = comment.copyWith(
          commentId: commentId, createdAt: DateTime.now().toString());

      CoustomLog.coustomLogData("postCommentReplay", uploadComment);

      await postCollection.setCommentDocument(
          postId, commentId, uploadComment.toMap());

      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("postCommentReplay", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> deletCommentReplay( String postId, String commentId) async {
    try {
      await postCollection.deletCommentDocument(postId, commentId);
      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("deletCommentReplay", error, stack);
      rethrow;
    }
  }



}






//  @override
//   Future<List<PostModel>> getAllFriendsPost(List<FollowModel> following) async {
//     try {
//       // DocumentSnapshot value = await FirebaseUserCollection().getUserDocument(
//       //   auth.currentUser!.uid.toString(),
//       // );
//       // final user = UserModel.fromMap(value.data() as Map<String, dynamic>);

      // List<String> followingUserUuid = following!
      //     .map((following) => following.uuid.toString())
      //     .toList();

      // for (String userId in followingUserUuid) {
      //   followingList =
      //       await postCollection.getUserSpecificPosts(userId.toString());

      //   followingList?.docs.forEach((element) {
      //     posts.add(PostModel.fromMap(element.data()));
      //   });
      // }
//       CoustomLog.coustomLogData("getAllFriendsPost", posts);
//       return posts;
//     } catch (error, stack) {
//       CoustomLog.coustomLogError("getAllFriendsPost", error, stack);
//       rethrow;
//     }
//   }