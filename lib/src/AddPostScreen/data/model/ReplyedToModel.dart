
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ReplyedToEntity.dart';


class ReplyedToModel extends ReplyedTo {
  ReplyedToModel({super.uuid, super.uniqueName, super.profileImage, super.commentId});
  ReplyedToModel copyWith({
    String? uuid,
    String? uniqueName,
    String? profileImage,
    String? commentId,
  }) {
    return ReplyedToModel(
        uuid: uuid ?? this.uuid,
        commentId: commentId ?? this.commentId,
        uniqueName: uniqueName ?? this.uniqueName,
        profileImage: profileImage ?? this.profileImage);
  }

  factory ReplyedToModel.fromEntity(ReplyedTo entity) {
    return ReplyedToModel(
      uuid: entity.uuid,
      commentId: entity.commentId,
      uniqueName: entity.uniqueName,
      profileImage: entity.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'commentId': commentId,
      'uniqueName': uniqueName,
      'profileImage': profileImage,
    };
  }

  factory ReplyedToModel.fromMap(Map<String, dynamic> map) {
    return ReplyedToModel(
      commentId: map['commentId'] != null ? map['commentId'] as String : null,
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:map['uniqueName'] != null ? map['uniqueName'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ReplyedToModel ('
        'uuid: $uuid, '
        'commentId: $commentId, '
        'uniqueName: $uniqueName, '
        'profileImage: $profileImage, )';
  }
}