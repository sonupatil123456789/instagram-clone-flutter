
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';

class FollowModel extends FollowEntity  {
  FollowModel({super.uuid, super.uniqueName, super.profileImage});

  FollowModel copyWith({
    String? uuid,
    String? uniqueName,
    String? profileImage,
  }) {
    return FollowModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        profileImage: profileImage ?? this.profileImage);
  }

  factory FollowModel.fromEntity(FollowEntity entity) {
    return FollowModel(
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

  factory FollowModel.fromMap(Map<String, dynamic> map) {
    return FollowModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:
          map['uniqueName'] != null ? map['uniqueName'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
    );
  }


  @override
  String toString() {
    return 'FollowModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'profileImage: $profileImage, )';
  }
}
