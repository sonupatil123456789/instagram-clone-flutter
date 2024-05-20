import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class GetMyPostUsecase implements UseCase<List<PostEntity>?, bool> {
  UserProfileScreenRepository reposatory;

  GetMyPostUsecase(
    this.reposatory,
  );

  @override
  Future<List<PostEntity>?> call(bool isRefresh, BuildContext context) async {
    try {
      return await reposatory.getMyPostPost(isRefresh);
    } catch (e) {
      return null;
    }
  }
}


