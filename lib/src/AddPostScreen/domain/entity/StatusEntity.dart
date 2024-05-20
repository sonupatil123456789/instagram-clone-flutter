// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ViewedStatusEntity.dart';
import 'TagPeopleEntity.dart';

class StatusEntity extends Equatable {
  String? statusId;
  String? statusDiscription;
  String? statusImage;
  String? statusImageFileType;
  List<TagPeopleEntity>? tagPeople;
  List<ViewedStatusEntity>? viewedStatus = [];
  String? createdAt;            

  StatusEntity(
      {this.statusDiscription,
      this.statusId,
      this.tagPeople,
      this.statusImage,
      this.statusImageFileType,
      this.viewedStatus,
      this.createdAt
      });

  @override
  List<Object?> get props {
    return [
      statusId,
      statusDiscription,
      statusImage,
      statusImageFileType,
      tagPeople,
      viewedStatus,
      createdAt,
    ];
  }
}
