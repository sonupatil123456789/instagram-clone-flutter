import 'package:equatable/equatable.dart';


class UserChatMessageEntity extends Equatable {
  String? uuid;
  String? messageId;
  bool? messageViewed = false;
  String? replyedToId;
  String? message;
  String? messageType;
  String? createdAt;

  UserChatMessageEntity({
  this.uuid, this.messageViewed, this.messageId, this.message,
  this.replyedToId,
  this.messageType,
  this.createdAt});
  
  @override
  // TODO: implement props
  List<Object?> get props => [uuid,messageViewed,messageId,replyedToId , message,messageType , createdAt];

}

