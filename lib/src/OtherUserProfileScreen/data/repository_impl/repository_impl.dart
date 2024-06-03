
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/repository/repository.dart';


class OtherUserRepositoryImpl implements OtherUserRepository{
  OtherUserRemoteDataSource otherUserRemoteDataSource ;

  OtherUserRepositoryImpl(this.otherUserRemoteDataSource);
  
  @override
  Future<UserEntity> getOtherUserDetails(String uuid) {
    return otherUserRemoteDataSource.getOtherUserDetails(uuid);
  }
  
  @override
  Stream<UserEntity> getOtherUserDetailsStream(String uuid) {
     return otherUserRemoteDataSource.getOtherUserDetailsStream(uuid);
  }
  
  @override
  Future<List<PostEntity>> getOtherUserPost(String uuid) {
     return otherUserRemoteDataSource.getOtherUserPost(uuid);
  }

 


  
}