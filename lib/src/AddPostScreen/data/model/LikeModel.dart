import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';


class LikeModel extends LikesEntity {
  LikeModel({super.uuid, super.uniqueName, super.profileImage});
  LikeModel copyWith({
    String? uuid,
    String? uniqueName,
    String? profileImage,
  }) {
    return LikeModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        profileImage: profileImage ?? this.profileImage);
  }

  factory LikeModel.fromEntity(LikesEntity entity) {
    return LikeModel(
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

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:map['uniqueName'] != null ? map['uniqueName'] as String : null,
      profileImage:map['profileImage'] != null ? map['profileImage'] as String : null,
    );
  }

  @override
  String toString() {
    return 'LikeModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'profileImage: $profileImage, )';
  }
}