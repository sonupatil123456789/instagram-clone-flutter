
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';


abstract interface class ReelScreenRemoteDataSource {


  Future<List<PostModel>> getAllVideoPost(isRefresh);

}
