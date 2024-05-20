

import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';



abstract interface class DiscoverRemoteDataSource {


 Future<FollowModel> followUser(FollowModel following );



}