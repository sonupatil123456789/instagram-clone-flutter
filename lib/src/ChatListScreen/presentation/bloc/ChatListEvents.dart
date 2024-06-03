



import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';

abstract class ChatListEvents {}


class SendMessageEvent extends  ChatListEvents{
  BuildContext context ;
  UserEntity sender ;
  UserEntity reciver ;
  UserChatMessageEntity messageData ;

  SendMessageEvent({
   required this.context,
   required this.sender,
   required this.reciver,
   required this.messageData,
  });

}

class ViewedMessageEvent extends  ChatListEvents{
  BuildContext context ;
   String senderId;
   String reciverId;
   String messageId;


  ViewedMessageEvent({
    required this.context,
    required this.senderId,
    required this.reciverId,
    required this.messageId,
  });

}
class ViewedLastMessageEvent extends  ChatListEvents{
  BuildContext context ;
   String senderId;
   String reciverId;


  ViewedLastMessageEvent({
    required this.context,
    required this.senderId,
    required this.reciverId,
  });

}
class DeletMessageEvent extends  ChatListEvents{
  BuildContext context ;
   String senderId;
   String reciverId;
   String messageId;


  DeletMessageEvent({
    required this.context,
    required this.senderId,
    required this.reciverId,
    required this.messageId,
  });

}





