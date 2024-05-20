
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


abstract interface class DiscoverRepository {


 
  Future<FollowModel> followUser(FollowEntity following );



}