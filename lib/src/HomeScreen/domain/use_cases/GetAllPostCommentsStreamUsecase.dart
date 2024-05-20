
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllPostCommentsStreamUsecase implements StreamedUseCase<Stream<List<CommentsEntity>>,  String > {
  HomeScreenRepository reposatory;

  GetAllPostCommentsStreamUsecase(this.reposatory);
  
  @override
  Stream<List<CommentsEntity>> call( String postId, BuildContext context) {
    try {
      return reposatory.getAllPostCommentsStream(postId);
    } catch (e) {
      rethrow;
    }
  }
  

}



