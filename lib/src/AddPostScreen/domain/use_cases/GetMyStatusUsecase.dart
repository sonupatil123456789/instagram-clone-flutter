import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class GetMyStatusUsecase implements UseCase<UserStatusEntity?, EmptyParams> {
  PostRepository reposatory;

  GetMyStatusUsecase(this.reposatory);

  @override
  Future<UserStatusEntity?> call(
      EmptyParams params, BuildContext context) async {
    try {
      final data = await reposatory.getMyStatus();
      return data;
    } catch (e) {
      print(e);
      ListnersUtils.showFlushbarMessage(
          "$e",
          errorColor,
          white,
          "Error",
          Icons.error,
          context);

      return null;
    }
  }
}
