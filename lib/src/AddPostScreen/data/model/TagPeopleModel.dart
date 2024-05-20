

import 'package:instagram_clone/src/AddPostScreen/domain/entity/TagPeopleEntity.dart';

class TagPeopleModel extends TagPeopleEntity {
  TagPeopleModel({super.uuid, super.uniqueName, super.profileImage});

  TagPeopleModel copyWith({
    String? uuid,
    String? uniqueName,
    String? profileImage,
  }) {
    return TagPeopleModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        profileImage: profileImage ?? this.profileImage);
  }

  factory TagPeopleModel.fromEntity(TagPeopleEntity entity) {
    return TagPeopleModel(
      uuid: entity.uuid,
      uniqueName: entity.uniqueName,
      profileImage: entity.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'uniqueName': uniqueName,
      'profileImage': profileImage,
    };
  }

  factory TagPeopleModel.fromMap(Map<String, dynamic> map) {
    return TagPeopleModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:
          map['uniqueName'] != null ? map['uniqueName'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
    );
  }

  @override
  String toString() {
    return 'TagPeopleModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'profileImage: $profileImage, )';
  }
}