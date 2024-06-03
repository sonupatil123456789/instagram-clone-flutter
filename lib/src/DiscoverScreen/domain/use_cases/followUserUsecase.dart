import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/DiscoverScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class FollowUserUsecase implements UseCase<bool, FollowUserParams> {
  DiscoverRepository reposatory;

  FollowUserUsecase(this.reposatory);
  
  @override
  Future<bool> call(FollowUserParams params, BuildContext context) async {
      try {
      return await reposatory.followUser(params.following);
    } catch (e) {
      rethrow ;
    }
  }

 
}

class FollowUserParams  {
  FollowEntity following;
  String? followingUuid;


  FollowUserParams({
    required this.following,
    this.followingUuid,
  });
}
