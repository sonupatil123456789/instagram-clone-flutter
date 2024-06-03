import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class SendMessageUsecase implements UseCase<bool, SendMessageParams> {
  ChatListRepository reposatory;

  SendMessageUsecase(this.reposatory);

  @override
  Future<bool> call(SendMessageParams params, BuildContext context) async {
    try {
      final messageSend = await reposatory.sendMessage(params.sender!, params.reciver !,params.messageData! );
      if (messageSend) {
        // Navigator.pop(context);
        return true ;
      } else {
        throw "Unable To Send Message";
      }
      
    } catch (e) {
      return false ;  
    }
  }
}

class SendMessageParams {
   UserEntity? sender;
   UserEntity? reciver;
   UserChatMessageEntity? messageData;

  SendMessageParams({
     this.sender,
     this.reciver,
     this.messageData,
  });
}