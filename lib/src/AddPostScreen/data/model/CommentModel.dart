
import 'package:instagram_clone/src/AddPostScreen/data/model/ReplyedToModel.dart';

import '../../domain/entity/CommentEntity.dart';

class CommentsModel extends CommentsEntity {
  CommentsModel(
      {super.uuid,
      super.uniqueName,
      super.commentId,
      super.replyedTo,
      super.profileImage,
      super.commentMessage,
      super.createdAt});

  CommentsModel copyWith({
    String? uuid,
    String? uniqueName,
    String? commentId,
    ReplyedToModel? replyedTo,
    String? commentMessage,
    String? profileImage,
    String? createdAt,
  }) {
    return CommentsModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        commentId: commentId ?? this.commentId,
        replyedTo: replyedTo ?? this.replyedTo,
        commentMessage: commentMessage ?? this.commentMessage,
        profileImage: profileImage ?? this.profileImage,
        createdAt: createdAt ?? this.createdAt);
  }

  factory CommentsModel.fromEntity(CommentsEntity entity) {
    return CommentsModel(
      uuid: entity.uuid,
      replyedTo: entity.replyedTo,
      commentId: entity.commentId,
      uniqueName: entity.uniqueName,
      commentMessage: entity.commentMessage,
      profileImage: entity.profileImage,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'uniqueName': uniqueName,
      'commentId': commentId,
      'replyedTo':replyedTo != null ? ReplyedToModel.fromEntity(replyedTo!).toMap() :<String, dynamic>{} ,
      'commentMessage': commentMessage,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }

  factory CommentsModel.fromMap(Map<String, dynamic> map) {
    return CommentsModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      commentId: map['commentId'] != null ? map['commentId'] as String : null,
      uniqueName:map['uniqueName'] != null ? map['uniqueName'] as String : null,
      replyedTo:map['replyedTo'] != null ? ReplyedToModel.fromMap(map['replyedTo'])  : ReplyedToModel(),
      commentMessage: map['commentMessage'] != null ? map['commentMessage'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  @override
  String toString() {
    return 'CommentsModel ('
        'uuid: $uuid, '
        'commentId: $commentId, '
        'replyedTo: $replyedTo, '
        'uniqueName: $uniqueName, '
        'commentMessage: $commentMessage, '
        'createdAt: $createdAt, '
        'profileImage: $profileImage, )';
  }
}