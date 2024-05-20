// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ViewedStatusEntity.dart';

import 'package:instagram_clone/src/AddPostScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class IsStatusViewedUsecase implements UseCase<bool, IsStatusViewedParams> {
  PostRepository reposatory;

  IsStatusViewedUsecase(this.reposatory);

  @override
  Future<bool> call( IsStatusViewedParams params, BuildContext context) async {
    try {
      bool data = await reposatory.viewedStatus(params.isStatusViewed, params.userId);
  
      Navigator.pop(context);
      return data;
    } catch (e) {
      return false;
    }
  }
}


class IsStatusViewedParams {
  String userId = '';
  ViewedStatusEntity isStatusViewed ;

  IsStatusViewedParams(
    this.userId,
    this.isStatusViewed,
  );
  
}
