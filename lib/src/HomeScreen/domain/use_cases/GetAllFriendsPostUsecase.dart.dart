import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllFriendsPostUsecase implements UseCase<List<PostEntity>?, GetAllFriendsPostParams> {
  HomeScreenRepository reposatory;

  GetAllFriendsPostUsecase(this.reposatory);
  
  @override
  Future<List<PostEntity>?> call(GetAllFriendsPostParams params, BuildContext context) async {
      try {
      return await reposatory.getAllFriendsPost(params.following ,params.isRefresh);
    } catch (e) {
      return null;
    }
  }

}

class GetAllFriendsPostParams  {
  List<FollowEntity> following = [];
  bool isRefresh ;


  GetAllFriendsPostParams({
    required this.following,
    required this.isRefresh,
  });
}
