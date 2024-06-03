import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class ViewedLastMessageUsecase implements UseCase< void , ViewedLastMessageParams> {
  ChatListRepository reposatory;

  ViewedLastMessageUsecase(this.reposatory);

  @override
  Future<void> call(ViewedLastMessageParams params, BuildContext context) async {
    try {
      await reposatory.viewedLastMessage(params.senderId, params.reciverId);
    } catch (e) {
      
    }
  }
}

class ViewedLastMessageParams {
   String senderId;
   String reciverId;


  ViewedLastMessageParams({
    required this.senderId,
    required this.reciverId,
  });
}