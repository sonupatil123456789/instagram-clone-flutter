
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


abstract interface class DiscoverRepository {


 
  // Future<FollowModel> followUser(FollowEntity following );

  Future<bool> followUser(FollowEntity following );



}