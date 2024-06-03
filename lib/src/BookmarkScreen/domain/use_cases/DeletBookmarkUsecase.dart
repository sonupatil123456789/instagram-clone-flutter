import 'package:flutter/material.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class DeletBookmarkUsecase implements UseCase<bool, String> {
  BookmarkRepository reposatory;

  DeletBookmarkUsecase(this.reposatory);
                                                                       
  @override
  Future<bool> call(String bookmarkId, BuildContext context) async {
    try {
      final isBookmarkDeleted = await reposatory.deletBookmark(bookmarkId);
      if (isBookmarkDeleted) {
        return true ;    
      } else {
        throw "Unable To Deleted bookmark";
      }
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          "Some error occured please check you internrt connection or try to open app after some time ",
          errorColor,
          white,
          "Unable To Deleted bookmark",
          Icons.error,
          context);
      return false ;
    }
  }
}


