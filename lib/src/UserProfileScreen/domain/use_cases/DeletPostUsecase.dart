
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class DeletMyPostUsecase implements UseCase<void, String> {
  UserProfileScreenRepository reposatory;

  DeletMyPostUsecase(
    this.reposatory,
  );

  @override
  Future<bool> call(String postId, BuildContext context) async {
    try {
      final isDelet = await reposatory.deletUserPost(postId);
      if (isDelet) {
           return true ;
      }
      throw 'Post deletion fail unexpectedly . Try after some Time';

    } catch (e) {
         ListnersUtils.showFlushbarMessage(
          "Post deletion fail unexpectedly . Try after some Time",
          errorColor,
          white,
          "Deletion Fail",
          Icons.error,
          context);
      return false;
    }
  }
}


