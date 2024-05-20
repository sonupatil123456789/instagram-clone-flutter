
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';



abstract interface class HomeScreenRepository {


 
  Future<List<PostEntity>> getAllFriendsPost(List<FollowEntity> following , bool isRefresh);

  Future<List<PostEntity>> getAllPost(isRefresh) ;

    Stream<List<PostEntity>> getAllPostStream(bool isRefresh);

  Stream<List<PostEntity>> getAllFriendsPostStream(
      List<FollowEntity> following, bool isRefresh);

   Future<LikesEntity> likePost(String postid , LikesEntity like);


  Stream<List<CommentsEntity>> getAllPostCommentsStream(String postId);

  Future<bool> postCommentReplay(String postId   , CommentsEntity comment);

  Future<bool> deletCommentReplay(String postId  , String commentId  );

   



}