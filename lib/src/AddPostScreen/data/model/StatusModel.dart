
import 'package:instagram_clone/src/AddPostScreen/data/model/TagPeopleModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/ViewedStatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';

class StatusModel extends StatusEntity {
  StatusModel(
      {
      super.statusId,
      super.statusDiscription,
      super.statusImage,
      super.statusImageFileType,
      super.tagPeople,
      super.viewedStatus,
      super.createdAt});

  StatusModel copyWith({
    String? statusId,
    String? statusDiscription,
    String? statusImage,
    String? statusImageFileType,
    List<TagPeopleModel>? tagPeople,
    List<ViewedStatusModel>? viewedStatus,
    String? createdAt,
  }) {
    return StatusModel(
      statusId: statusId ?? this.statusId,
      statusDiscription: statusDiscription ?? this.statusDiscription,
      statusImage: statusImage ?? this.statusImage,
      statusImageFileType: statusImageFileType ?? this.statusImageFileType,
      tagPeople: tagPeople ?? this.tagPeople,
      createdAt: createdAt ?? this.createdAt,
      viewedStatus:viewedStatus?? this.viewedStatus,
    );
  }

  factory StatusModel.fromEntity(StatusEntity entity) {
    return StatusModel(
      statusId: entity.statusId,
      statusDiscription: entity.statusDiscription,
      createdAt: entity.createdAt,
      tagPeople: entity.tagPeople,
      statusImage: entity.statusImage,
      statusImageFileType: entity.statusImageFileType,
      viewedStatus: entity.viewedStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusId': statusId,
      'statusDiscription': statusDiscription,
      'statusImage': statusImage,
      'statusImageFileType': statusImageFileType,
      'viewedStatus': viewedStatus?.map((e) => ViewedStatusModel(
       uuid: e.uuid,
              uniqueName: e.uniqueName,
              profileImage: e.profileImage
      ).toMap()).toList(),
      'tagPeople': tagPeople?.map((e) => TagPeopleModel(
              uuid: e.uuid,
              uniqueName: e.uniqueName,
              profileImage: e.profileImage
        ).toMap()).toList(),
      'createdAt': createdAt,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      statusId: map['statusId'] != null ? map['statusId'] as String : null,
      statusImage: map['statusImage'] != null ? map['statusImage'] as String : null,
      statusImageFileType: map['statusImageFileType'] != null
          ? map['statusImageFileType'] as String
          : null,
      statusDiscription: map['statusDiscription'] != null
          ? map['statusDiscription'] as String
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      tagPeople: map['tagPeople'] != null ? (map['tagPeople'] as List<dynamic>).map((data) => TagPeopleModel.fromMap(data)).toList() : [],
      viewedStatus: map['viewedStatus'] != null ? (map['viewedStatus'] as List<dynamic>).map((data) => ViewedStatusModel.fromMap(data)).toList() : [],
    );
  }

  @override
  String toString() {
    return 'StatusModel ('
        'statusId: $statusId, '
        'statusImage: $statusImage, '
        'statusImageFileType: $statusImageFileType, '
        'statusDiscription: $statusDiscription, '
        'tagPeople: $tagPeople, '
        'viewedStatus: $viewedStatus, '
        'createdAt: $createdAt )';
  }
}






