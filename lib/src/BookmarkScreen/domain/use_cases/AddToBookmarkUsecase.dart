import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../repository/repository.dart';

class AddToBookmarkUsecase implements UseCase<void, PostEntity> {
  BookmarkRepository reposatory;

  AddToBookmarkUsecase(this.reposatory);

  @override
  Future<void> call(PostEntity bookmark, BuildContext context) async {
    try {
      final isBookmarkAdded = await reposatory.postBookmark(bookmark);
      if (isBookmarkAdded) {
        ListnersUtils.showFlushbarMessage(
            "Added to bookmark Successfull",
            successColor,
            white,
            "Success",
            Icons.done,
            context);
      } else {
        throw "Unable To Post bookmark";
      }
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          "Some error occured please check you internrt connection or try to open app after some time ",
          errorColor,
          white,
          "Unable To Post bookmark",
          Icons.error,
          context);
    }
  }
}

