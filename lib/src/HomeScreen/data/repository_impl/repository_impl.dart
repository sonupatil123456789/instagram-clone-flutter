
import 'package:instagram_clone/src/AddPostScreen/data/model/CommentModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/LikeModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';

import '../data_sources/remote_data_source.dart';

class HomeScreenRepositoryImpl implements HomeScreenRepository {
  HomeScreenRemoteDataSource homeScreenRemoteDataSource;

  HomeScreenRepositoryImpl(this.homeScreenRemoteDataSource);

  @override
  Future<List<PostEntity>> getAllFriendsPost(
    List<FollowEntity> following , bool isRefresh ) async {
    return await homeScreenRemoteDataSource.getAllFriendsPost(following.map((e) => FollowModel.fromEntity(e)).toList() , isRefresh);
  }
  
  @override
  Future<List<PostEntity>> getAllPost(isRefresh) async{
    return await homeScreenRemoteDataSource.getAllPost(isRefresh);
  }

  @override
  Future<LikesEntity> likePost(String postid, LikesEntity like) async{
    return await homeScreenRemoteDataSource.likePost(postid, LikeModel.fromEntity(like));
  }
  
  @override
  Stream<List<PostEntity>> getAllFriendsPostStream(List<FollowEntity> following, bool isRefresh) {
    return  homeScreenRemoteDataSource.getAllFriendsPostStream(following.map((e) => FollowModel.fromEntity(e)).toList() , isRefresh);
  }
  
  @override
  Stream<List<PostEntity>> getAllPostStream(bool isRefresh) {
     return homeScreenRemoteDataSource.getAllPostStream(isRefresh);
  }

  @override
  Stream<List<CommentsEntity>> getAllPostCommentsStream(String postId, ) {
    return homeScreenRemoteDataSource.getAllPostCommentsStream(postId);
  }

  @override
  Future<bool> postCommentReplay(String postId,  CommentsEntity comment) {
   return homeScreenRemoteDataSource.postCommentReplay(postId,  CommentsModel.fromEntity(comment));
  }
  
  @override
  Future<bool> deletCommentReplay(String postId, String commentId) {
    return homeScreenRemoteDataSource.deletCommentReplay(postId, commentId);
  }
  
  
}
