import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';


abstract interface class OtherUserRemoteDataSource {

 Future<List<PostModel>> getOtherUserPost(String uuid );

 Future<UserModel> getOtherUserDetails(String uuid );

 Stream<UserModel> getOtherUserDetailsStream(String uuid);

}