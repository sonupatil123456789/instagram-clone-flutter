
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';




abstract interface class UserProfileScreenRepository {

  Future<List<PostEntity>> getMyPostPost(isRefresh) ;

   Future<bool> deletUserPost(String postId );

}