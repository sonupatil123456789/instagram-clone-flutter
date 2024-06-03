import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserMessageListEntity.dart';

class UserMessageListModel extends UserMessageListEntity {
// class UserMessageListModel extends UserEntity implements Equatable  {
  UserMessageListModel({
    super.uuid,
    super.uniqueName,
    super.userName,
    super.email,
    super.phoneNumber,
    super.isOnline,
    super.profileImage,
    super.messageCreatedAt,
    super.messageId,
    super.messageViewed,
    super.message,
    super.messageType,
  });

  UserMessageListModel copyWith({
    String? uuid,
    String? uniqueName,
    String? userName,
    String? email,
    String? phoneNumber,
    String? profileImage,
    bool? isOnline,
    String? messageCreatedAt,
    String? messageId,
    String? message,
    bool? messageViewed,
    String? messageType,
  }) {
    return UserMessageListModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isOnline: isOnline ?? this.isOnline,
        profileImage: profileImage ?? this.profileImage,
        messageCreatedAt: messageCreatedAt ?? this.messageCreatedAt,
        messageId: messageId ?? this.messageId,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        messageViewed: messageViewed ?? this.messageViewed);
  }

  factory UserMessageListModel.fromEntity(UserMessageListEntity entity) {
    return UserMessageListModel(
      uuid: entity.uuid,
      uniqueName: entity.uniqueName,
      userName: entity.userName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      isOnline: entity.isOnline,
      profileImage: entity.profileImage,
      messageCreatedAt: entity.messageCreatedAt,
      messageId: entity.messageId,
      messageViewed: entity.messageViewed,
      message: entity.message,
      messageType: entity.messageType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'uniqueName': uniqueName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'profileImage': profileImage,
      'messageCreatedAt': messageCreatedAt,
      'messageId': messageId,
      'messageViewed': messageViewed,
      'message': message,
      'messageType': messageType,
    };
  }

  factory UserMessageListModel.fromMap(Map<String, dynamic> map) {
    return UserMessageListModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:
          map['uniqueName'] != null ? map['uniqueName'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      messageCreatedAt: map['messageCreatedAt'] != null
          ? map['messageCreatedAt'] as String
          : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      messageId: map['messageId'] != null ? map['messageId'] as String : '',
      message: map['message'] != null ? map['message'] as String : '',
      messageType:
          map['messageType'] != null ? map['messageType'] as String : '',
      messageViewed:
          map['messageViewed'] != null ? map['messageViewed'] as bool : false,
    );
  }

  @override
  String toString() {
    return 'UserMessageListModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'userName: $userName, '
        'email: $email, '
        'profileImage: $profileImage, '
        'phoneNumber: $phoneNumber, '
        'isOnline: $isOnline, '
        'messageId: $messageId, '
        'messageType: $messageType, '
        'message: $message, '
        'messageViewed: $messageViewed, '
        'messageCreatedAt: $messageCreatedAt )';
  }
}
