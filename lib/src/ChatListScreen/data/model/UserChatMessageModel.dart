
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';


class UserChatMessageModel extends UserChatMessageEntity {


  UserChatMessageModel({super.uuid, 
  super.messageId, 
  super.messageViewed,
  super.replyedToId,
  super.message,
  super.messageType,
  super.createdAt,
  });


  UserChatMessageModel copyWith({
    String? uuid,
    String? messageId,
    String? replyedToId,
    String? message,
    String? messageType,
    String? createdAt,
    bool? messageViewed,
  }) {
    return UserChatMessageModel(
        uuid: uuid ?? this.uuid,
        messageId: messageId ?? this.messageId,
        replyedToId: replyedToId ?? this.replyedToId,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        createdAt: createdAt ?? this.createdAt,
        messageViewed: messageViewed ?? this.messageViewed);
  }

  factory UserChatMessageModel.fromEntity(UserChatMessageEntity entity) {
    return UserChatMessageModel(
      uuid: entity.uuid,
      messageId: entity.messageId,
      replyedToId: entity.replyedToId,
      messageViewed: entity.messageViewed,
      message: entity.message,
      messageType: entity.messageType,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'messageId': messageId,
      'messageViewed': messageViewed,
      'message': message,
      'messageType': messageType,
      'createdAt': createdAt,
      'replyedToId': replyedToId,
    };
  }

  factory UserChatMessageModel.fromMap(Map<String, dynamic> map) {
    return UserChatMessageModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      messageId:map['messageId'] != null ? map['messageId'] as String : '',
      replyedToId:map['replyedToId'] != null ? map['replyedToId'] as String : '',
      message:map['message'] != null ? map['message'] as String : '',
      messageType:map['messageType'] != null ? map['messageType'] as String : '',
      createdAt:map['createdAt'] != null ? map['createdAt'] as String : null,
      messageViewed:map['messageViewed'] != null ? map['messageViewed'] as bool : false,
    );
  }

  @override
  String toString() {
    return 'UserChatMessageModel ('
        'uuid: $uuid, '
        'messageId: $messageId, '
        'replyedToId: $replyedToId, '
        'messageType: $messageType, '
        'createdAt: $createdAt, '
        'message: $message, '
        'messageViewed: $messageViewed, )';
  }
}