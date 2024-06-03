import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';


class GetAllUsersBookmarkUsecase implements UseCase<List<PostEntity>?, bool> {
  BookmarkRepository reposatory;

  GetAllUsersBookmarkUsecase(this.reposatory,);
  
  @override
  Future<List<PostEntity>?> call(bool isRefresh, BuildContext context) async {
      try {
      return await reposatory.getMyBookmarks(isRefresh);
    } catch (e) {
      return null;
    }
  }

}


