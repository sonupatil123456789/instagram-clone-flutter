


import 'package:instagram_clone/src/AddPostScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/StatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/UserStatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/ViewedStatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ViewedStatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/repository/repository.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


class PostRepositoryImpl implements PostRepository{
  PostRemoteDataSource postRemoteDataSource ;

  PostRepositoryImpl(this.postRemoteDataSource);


  @override
  Future<PostEntity> uploadPost(PostEntity post) async {
   return  await postRemoteDataSource.uploadPost(PostModel.fromEntity(post));
  }

  @override
  Future<bool> uploadStatus(StatusEntity status)async {
    return await postRemoteDataSource.uploadStatus(StatusModel.fromEntity(status));
  }

 

  @override
  Future<bool> viewedStatus(ViewedStatusEntity isStatusViewed, String userId) async{
    return  await postRemoteDataSource.viewedStatus(ViewedStatusModel.fromEntity(isStatusViewed) , userId);
  }


  @override
  Stream<List<UserStatusModel>> getAllStatus(List<FollowEntity> followers) {
    return postRemoteDataSource.getAllStatus(followers.map((e) => FollowModel.fromEntity(e)).toList());
  }
  
  
  @override
  Future<UserStatusEntity> getMyStatus() async{
    return await postRemoteDataSource.getMyStatus();
  }
  
}