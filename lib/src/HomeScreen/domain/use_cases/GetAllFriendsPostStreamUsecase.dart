import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllFriendsPostUsecase.dart.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllFriendsPostStreamUsecase implements StreamedUseCase<Stream<List<PostEntity>>, GetAllFriendsPostParams> {
  HomeScreenRepository reposatory;

  GetAllFriendsPostStreamUsecase(this.reposatory);
  
  @override
  Stream<List<PostEntity>> call(GetAllFriendsPostParams params, BuildContext context) {
    try {
      return reposatory.getAllFriendsPostStream(params.following, params.isRefresh);
    } catch (e) {
      rethrow;
    }
  }
  


}


