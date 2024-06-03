


import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class GetOtherUserPostsUsecase implements UseCase<List<PostEntity>, String>{
  OtherUserRepository reposatory;

  GetOtherUserPostsUsecase(this.reposatory);
  @override
  Future<List<PostEntity>>  call(String uuid, BuildContext context) {
    try {
      return reposatory.getOtherUserPost(uuid)  ;  
    } catch (e) {
      rethrow;
    }
  }

}