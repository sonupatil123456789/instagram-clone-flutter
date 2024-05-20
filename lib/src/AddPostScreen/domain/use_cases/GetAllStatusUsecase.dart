
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/repository/repository.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class GetAllStatusUsecase implements StreamedUseCase<Stream<List<UserStatusEntity>> , List<FollowEntity>>{
  PostRepository reposatory;

  GetAllStatusUsecase(this.reposatory);
  @override
  Stream<List<UserStatusEntity>> call(List<FollowEntity> following, BuildContext context) {

    try {
      return reposatory.getAllStatus(following);
    } catch (e) {
      rethrow;
    }
    
  }

}