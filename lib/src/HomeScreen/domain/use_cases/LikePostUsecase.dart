import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';


class LikePostUsecase implements UseCase<LikesEntity?, LikePostParams> {
  HomeScreenRepository reposatory;

  LikePostUsecase(this.reposatory);
  
  @override
  Future<LikesEntity?> call(LikePostParams params, BuildContext context) async {
      try {
      return await reposatory.likePost(params.postId ,params.likePost);
    } catch (e) {
         ListnersUtils.showFlushbarMessage(
            "Some error occured please check you internrt connection or try to open app after some time ",
            errorColor,
            white,
            "Unable To Like Post ",
            Icons.error,
            context);

    }
  }

}

class LikePostParams  {
  LikesEntity likePost ;
  String postId ;


  LikePostParams({
    required this.likePost,
    required this.postId, 
  });
}
