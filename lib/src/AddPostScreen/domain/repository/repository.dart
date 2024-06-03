
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ViewedStatusEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


abstract interface class PostRepository {


  Future<PostEntity> uploadPost(PostEntity post);

  Future<bool> uploadStatus(StatusEntity status);

  Stream<List<UserStatusEntity>> getAllStatus(List<FollowEntity> followers);

  Future<bool> viewedStatus(ViewedStatusEntity isStatusViewed , String userId);

  Future<UserStatusEntity> getMyStatus();



}