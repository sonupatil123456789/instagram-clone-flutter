import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllPostUsecase.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllPostStreamUsecase implements StreamedUseCase<Stream<List<PostEntity>>, GetAllPostParams> {
  HomeScreenRepository reposatory;

  GetAllPostStreamUsecase(this.reposatory,);
  
  @override
  Stream<List<PostEntity>> call(GetAllPostParams params, BuildContext context) {
    try {
       return reposatory.getAllPostStream(params.isRefresh);
    } catch (e) {
      rethrow ;
    }
  }
  

}


