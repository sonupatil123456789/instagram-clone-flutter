import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

import '../entity/TagPeopleEntity.dart';


class UploadStatusUsecase implements UseCase<bool, UploadStatusParams> {
  PostRepository reposatory;

  UploadStatusUsecase(this.reposatory);

  @override
  Future<bool> call(UploadStatusParams params, BuildContext context) async {
    try {
      final isComentes = await reposatory.uploadStatus(params);
      if (isComentes) {
        ListnersUtils.showFlushbarMessage(
            "Status Uploaded Successfull",
            successColor,
            white,
            "Success",
            Icons.done,
            context);

        Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainSectionScreen, (route) => route.isFirst);
         return true ;
      } else {
        throw "Unable To Uploaded Comment";
      }
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          "Some error occured please check you internrt connection or try to open app after some time ",
          errorColor,
          white,
          "Unable To Uploaded Status",
          Icons.error,
          context);

         return false ;  
    }
  }
}

class UploadStatusParams extends StatusEntity{
   @override
  String? statusImageFileType;
   @override
  String? statusImage;
   @override
  String? statusDiscription;
   @override
  List<TagPeopleEntity>? tagPeople;


  UploadStatusParams({
     this.statusImageFileType,
     this.statusImage,
     this.statusDiscription,
     this.tagPeople,
  });
}