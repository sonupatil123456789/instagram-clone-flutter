
import '../../domain/entity/ViewedStatusEntity.dart';


class ViewedStatusModel extends ViewedStatusEntity {
  ViewedStatusModel({super.uuid, super.uniqueName, super.profileImage});
  ViewedStatusModel copyWith({
    String? uuid,
    String? uniqueName,
    String? profileImage,
  }) {
    return ViewedStatusModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        profileImage: profileImage ?? this.profileImage
        );
  }

  factory ViewedStatusModel.fromEntity(ViewedStatusEntity entity) {
    return ViewedStatusModel(
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

  factory ViewedStatusModel.fromMap(Map<String, dynamic> map) {
    return ViewedStatusModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:
          map['uniqueName'] != null ? map['uniqueName'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ViewedStatusModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'profileImage: $profileImage, )';
  }
}