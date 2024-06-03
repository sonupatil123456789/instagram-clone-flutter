
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';

abstract interface class UserProfileScreenRemoteDataSource {


  Future<List<PostModel>> getMyPostPost(isRefresh);

  Future<bool> deletUserPost(String postId );




}
