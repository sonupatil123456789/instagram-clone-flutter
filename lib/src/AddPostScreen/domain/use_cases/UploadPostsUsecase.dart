import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/TagPeopleEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class UploadPostsUsecase implements UseCase<PostEntity?, UploadPostsParams> {
  PostRepository reposatory;

  UploadPostsUsecase(this.reposatory);

  @override
  Future<PostEntity?> call( UploadPostsParams params, BuildContext context) async {
    try {
      PostEntity data = await reposatory.uploadPost(params);

       ListnersUtils.showFlushbarMessage(
          "Post Uploaded Successfull",
          successColor,
          white,
          "Success",
          Icons.done,
          context);
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainSectionScreen, (route) => route.isFirst);
          return data;
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          "Post uploading fail unexpectedly . Try after some Time ",
          errorColor,
          white,
          "Uploading Fail",
          Icons.error,
          context);

      return null;
    }
  }
}

class UploadPostsParams extends PostEntity {
  @override
  String? postDiscription;
  @override
  String? uniqueName;
  @override
  String? location;
  @override
  String? profileImage;
  @override
  String? postImage;
  @override
  String? postImageFileType;
  @override
  List<String>? tags;
  @override
  List<TagPeopleEntity>? tagPeople;

  UploadPostsParams({
    this.postDiscription,
    this.uniqueName,
    this.location,
    this.tags,
    this.tagPeople,
    this.profileImage,
    this.postImage,
    this.postImageFileType,
  });
}
