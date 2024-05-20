import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ViewedStatusEntity.dart';

import 'package:instagram_clone/utils/screen_utils/file_model.dart';

import '../../domain/entity/TagPeopleEntity.dart';

abstract class PostEvents {}



class TagPeopleEvent extends PostEvents{
  BuildContext context;
  TagPeopleEntity tagPeoples;
  TagPeopleEvent({
    required this.context,
    required this.tagPeoples,
  });
}

class HashTagEvent extends PostEvents{
  BuildContext context;
  String hashTags;

  HashTagEvent({
    required this.context,
    required this.hashTags,
  });
}


class UploadPostEvent extends PostEvents{
  BuildContext context;
  FileData fileData ;
  String location ;
  String discription ;
  String uniqueName ;
  String profileImage ;

  UploadPostEvent({
    required this.context,
    required this.fileData,
    required this.discription,
    required this.location,
    required this.profileImage,
    required this.uniqueName,
  });
}

class UploadStatusEvent extends PostEvents{
  BuildContext context;
  FileData fileData;
  String discription ;

  UploadStatusEvent({
    required this.context,
    required this.fileData,
    required this.discription,
  });
}


class GetMyStatusEvent extends PostEvents{
  BuildContext context;
  GetMyStatusEvent({
    required this.context,
  });
}


class IsStatusViewedEvent extends PostEvents{
  BuildContext context;
  ViewedStatusEntity isStatusViewed;
  String userId;
  IsStatusViewedEvent({
    required this.context,
    required this.isStatusViewed,
    required this.userId,
  });
}