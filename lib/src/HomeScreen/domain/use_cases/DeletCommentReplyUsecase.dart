import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../repository/repository.dart';

class DeletCommentReplyUsecase implements UseCase<void, DeletCommentReplyParams> {
  HomeScreenRepository reposatory;

  DeletCommentReplyUsecase(this.reposatory);

  @override
  Future<void> call(DeletCommentReplyParams params, BuildContext context) async {
    try {
      final isComentes = await reposatory.deletCommentReplay(
          params.postId, params.commentId);
      if (isComentes) {
        ListnersUtils.showFlushbarMessage(
            "Comment Deleted Successfull",
            successColor,
            white,
            "Success",
            Icons.done,
            context);
      } else {
        throw "Unable To Deleted Comment";
      }
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          "Some error occured please check you internrt connection or try to open app after some time ",
          errorColor,
          white,
          "Unable To Deleted Comment",
          Icons.error,
          context);
    }
  }
}

class DeletCommentReplyParams {
  String commentId;
  String postId;

  DeletCommentReplyParams({
    required this.commentId,
    required this.postId,
  });
}
