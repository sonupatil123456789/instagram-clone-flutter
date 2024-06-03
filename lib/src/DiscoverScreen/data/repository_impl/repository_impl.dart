


import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/DiscoverScreen/domain/repository/repository.dart';

import '../data_sources/remote_data_source.dart';

class DiscoverRepositoryImpl implements DiscoverRepository{
  DiscoverRemoteDataSource discoverRemoteDataSource ;

  DiscoverRepositoryImpl(this.discoverRemoteDataSource);


  @override
  Future<bool> followUser(FollowEntity following) async {
    return await discoverRemoteDataSource.followUser(FollowModel.fromEntity(following));
  }

  
}