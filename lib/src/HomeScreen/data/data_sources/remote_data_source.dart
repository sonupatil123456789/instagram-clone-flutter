import 'package:instagram_clone/src/AddPostScreen/data/model/CommentModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/LikeModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';

abstract interface class HomeScreenRemoteDataSource {
  Future<List<PostModel>> getAllFriendsPost(
  List<FollowModel> following, bool isRefresh);

  Future<List<PostModel>> getAllPost(isRefresh);

  Stream<List<PostModel>> getAllPostStream(bool isRefresh);

  Stream<List<PostModel>> getAllFriendsPostStream(
      List<FollowModel> following, bool isRefresh);

  Future<LikeModel> likePost(String postid, LikeModel like);

  Stream<List<CommentsModel>> getAllPostCommentsStream(String postId);

  Future<bool> postCommentReplay(String postId  , CommentsModel comment);

  Future<bool> deletCommentReplay(String postId  , String commentId  );

}
