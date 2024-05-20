import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../repository/repository.dart';

class PostCommentReplyUsecase implements UseCase<void, PostCommentReplyParams> {
  HomeScreenRepository reposatory;

  PostCommentReplyUsecase(this.reposatory);

  @override
  Future<void> call(PostCommentReplyParams params, BuildContext context) async {
    try {
      final isComentes = await reposatory.postCommentReplay(
          params.postId, params.comment);
      if (isComentes) {
        ListnersUtils.showFlushbarMessage(
            "Comment Posted Successfull",
            successColor,
            white,
            "Success",
            Icons.done,
            context);
      } else {
        throw "Unable To Post Comment";
      }
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          "Some error occured please check you internrt connection or try to open app after some time ",
          errorColor,
          white,
          "Unable To Post Comment",
          Icons.error,
          context);
    }
  }
}

class PostCommentReplyParams {
  CommentsEntity comment;
  String postId;

  PostCommentReplyParams({
    required this.comment,
    required this.postId,
  });
}
