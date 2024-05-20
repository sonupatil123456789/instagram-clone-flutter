import 'package:instagram_clone/src/AddPostScreen/data/model/StatusModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';


class UserStatusModel extends UserStatusEntity {
  UserStatusModel({super.uuid, super.uniqueName, super.profileImage, super.statusList});
  UserStatusModel copyWith({
    String? uuid,
    String? uniqueName,
    String? profileImage,
    List<StatusModel>? statusList
  }) {
    return UserStatusModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        statusList: statusList ?? this.statusList,
        profileImage: profileImage ?? this.profileImage);
  }

  factory UserStatusModel.fromEntity(UserStatusEntity entity) {
    return UserStatusModel(
      uuid: entity.uuid,
      statusList : entity.statusList,
      uniqueName: entity.uniqueName,
      profileImage: entity.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'uniqueName': uniqueName,
      'profileImage': profileImage,
      'statusList': statusList?.map((e) => StatusModel.fromEntity(e).toMap()).toList() ,
    };
  }

  factory UserStatusModel.fromMap(Map<String, dynamic> map) {
    return UserStatusModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:map['uniqueName'] != null ? map['uniqueName'] as String : null,
      profileImage:map['profileImage'] != null ? map['profileImage'] as String : null,
      statusList: map['statusList'] != null ? (map['statusList'] as List<dynamic>).map((data) => StatusModel.fromMap(data)).toList() : [],
    );
  }

  @override
  String toString() {
    return 'UserStatusModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'statusList: $statusList, '
        'profileImage: $profileImage, )';
  }
}