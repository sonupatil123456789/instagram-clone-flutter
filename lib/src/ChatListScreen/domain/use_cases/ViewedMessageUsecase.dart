import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class ViewedMessageUsecase implements UseCase< void , ViewedMessageParams> {
  ChatListRepository reposatory;

  ViewedMessageUsecase(this.reposatory);

  @override
  Future<void> call(ViewedMessageParams params, BuildContext context) async {
    try {
      await reposatory.viewedMessage(params.senderId, params.reciverId,params.messageId);
    } catch (e) {
      
    }
  }
}

class ViewedMessageParams {
   String senderId;
   String reciverId;
   String messageId;


  ViewedMessageParams({
    required this.senderId,
    required this.reciverId,
    required this.messageId,
  });
}