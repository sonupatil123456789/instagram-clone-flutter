

import 'package:equatable/equatable.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


class UserMessageListEntity extends Equatable {

  String? uuid;
  String? uniqueName ;
  String? userName ;
  String? email ;
  String? profileImage ;
  String? phoneNumber;
  bool? isOnline ;
  String? messageCreatedAt;
  String? messageId;
  bool? messageViewed = false;
  String? message;
  String? messageType;

  UserMessageListEntity({
    this.uuid,
    this.uniqueName,
    this.userName,
    this.profileImage,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.messageCreatedAt,
    this.messageId,
    this.messageViewed,
    this.message,
    this.messageType,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props =>[
    uuid,
    uniqueName,
    userName,
    profileImage,
    email,
    phoneNumber,
    isOnline,
    messageCreatedAt,
    messageId,
    messageViewed,
    message,
    messageType,
  ];

}






