import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/ReelsScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllVideoPostUsecase implements UseCase<List<PostEntity>?, bool> {
  ReelScreenRepository reposatory;

  GetAllVideoPostUsecase(this.reposatory,);
  
  @override
  Future<List<PostEntity>?> call(bool isRefresh, BuildContext context) async {
    try {
      return await reposatory.getAllVideoPost(isRefresh);
    } catch (e) {
      return null;
    }
  }

}


