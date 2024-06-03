import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebasePostCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseStatusCollection.dart';
import 'package:instagram_clone/core/firebaseServices/storage/storageBucket.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/StatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/TagPeopleModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/UserStatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/ViewedStatusModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'package:uuid/uuid.dart';

import '../model/LikeModel.dart';
import 'remote_data_source.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  FirebasePostCollection postCollection;
  FirebaseStatusCollection statusCollection;
  PostModel postModel;
  StorageBucket storage;
  UserModel userData;

  PostRemoteDataSourceImpl(
    this.postCollection,
    this.postModel,
    this.storage,
    this.statusCollection,
    this.userData,
  );

  FirebaseAuth get auth => postCollection.firebaseAuthInstance;

  @override
  Future<PostModel> uploadPost(PostModel post) async {
    try {
      final userId = auth.currentUser!.uid;
      final imageUrl = await storage.uploadPostFile(
          post.postImage.toString(), post.postImageFileType, userId.toString());

      final postId = Uuid().v4();

      postModel = postModel.copyWith(
        uuid: userId,
        postId: postId,
        uniqueName: post.uniqueName,
        profileImage: post.profileImage,
        postImage: imageUrl,
        postImageFileType: post.postImageFileType,
        postDiscription: post.postDiscription,
        createdAt: DateTime.now().toString(),
        location: post.location,
        likes: post.likes != null
            ? post.likes!.map((likes) => LikeModel.fromEntity(likes)).toList()
            : [],
        tagPeople: post.tagPeople != null
            ? post.tagPeople!
                .map((tagPeople) => TagPeopleModel.fromEntity(tagPeople))
                .toList()
            : [],
        tags: post.tags != null ? post.tags!.map((tags) => tags).toList() : [],
      );
      CoustomLog.coustomLogData("uploadPost", postModel.toMap());

      await postCollection.setPostDocument(postId, postModel.toMap());
      return postModel;
    } catch (error, stack) {
      CoustomLog.coustomLogError("uploadPost", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> uploadStatus(StatusModel status) async {
    Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');
    HiveUserModel? user = userDataBase.get("User");
    final statusId = Uuid().v4();
    try {
      final imageUrl = await storage.uploadStatusFile(status.statusImage.toString(),status.statusImageFileType, user!.uuid.toString());

      final statusData = status.copyWith(
        statusId: statusId,
        statusImage: imageUrl,
        createdAt: DateTime.now().toString(),
        viewedStatus: [],
      );

      CoustomLog.coustomLogData("uploadStatus", statusData.toMap());

      await statusCollection.updateStatusArrey( user!.uuid!,"statusList", statusData.toMap());
      // await statusCollection.setStatus( user!.uuid!,statusId, statusData.toMap());

      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("uploadStatus", error, stack);
      rethrow;
    }
  }




  @override
  Future<bool> viewedStatus(ViewedStatusModel isStatusViewed , String userId) async{
    CoustomLog.coustomLogData("ViewedStatus", isStatusViewed.toMap());
    try {
     await  statusCollection.updateStatusArrey(userId , "viewedStatus" , isStatusViewed.toMap());
     return true;
    }  catch (error, stack) {
      CoustomLog.coustomLogError("viewedStatus", error, stack);      
      rethrow;
    }
  }
  

  
  @override
  Stream<List<UserStatusModel>> getAllStatus(List<FollowModel> followers) {
        try {
       List<String> followingUserUuid =followers.map((followers) => followers.uuid.toString()).toList();
      Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshotStream =statusCollection.getAllStatusDocument(followingUserUuid);
      final statusList = querySnapshotStream.map((event) => event.docs
          .map((status) => UserStatusModel.fromMap(status.data()))
          .toList());

      statusList.listen((event) {
        CoustomLog.coustomLogData("getAllStatus", event.map((e) => e));
      });
      return statusList;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllStatus", error, stack);
      rethrow;
    }
  }
  


  @override
  Future<UserStatusModel> getMyStatus() async {
    final userId = auth.currentUser!.uid;
   try {
      final myStatus =  await statusCollection.getStatusDocument(userId);
      final status = UserStatusModel.fromMap(myStatus.data() as Map<String,dynamic>);
      CoustomLog.coustomLogData("getMyStatus", status);
      return status;
   }  catch (error, stack) {
      CoustomLog.coustomLogError("getMyStatus", error, stack);
      rethrow ;
    }
  }
}

