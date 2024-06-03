import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/StatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/UserStatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/ViewedStatusModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';


abstract interface class PostRemoteDataSource {


 Future<PostModel> uploadPost(PostModel post);

 Future<bool> uploadStatus(StatusModel status);

Future<bool> viewedStatus(ViewedStatusModel isStatusViewed , String userId);

 Stream<List<UserStatusModel>> getAllStatus(List<FollowModel> followers);

 Future<UserStatusModel> getMyStatus();



}