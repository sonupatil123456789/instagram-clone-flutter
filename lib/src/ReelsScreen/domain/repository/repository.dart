
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';



abstract interface class ReelScreenRepository {

  Future<List<PostEntity>> getAllVideoPost(isRefresh) ;

}