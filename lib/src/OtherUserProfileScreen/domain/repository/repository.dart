
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';


abstract interface class OtherUserRepository {


 Future<List<PostEntity>> getOtherUserPost(String uuid );

 Future<UserEntity> getOtherUserDetails(String uuid );

 Stream<UserEntity> getOtherUserDetailsStream(String uuid);

}