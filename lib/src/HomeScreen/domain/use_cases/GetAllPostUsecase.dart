import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllPostUsecase implements UseCase<List<PostEntity>?, GetAllPostParams> {
  HomeScreenRepository reposatory;

  GetAllPostUsecase(this.reposatory,);
  
  @override
  Future<List<PostEntity>?> call(GetAllPostParams params, BuildContext context) async {
      try {
      return await reposatory.getAllPost(params.isRefresh);
    } catch (e) {
      return null;
    }
  }

}

class GetAllPostParams  {
  bool isRefresh ;
  GetAllPostParams({
    required this.isRefresh,
  });
}
