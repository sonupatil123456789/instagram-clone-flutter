import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class DeletMessageUsecase implements UseCase< bool , DeletMessageParams> {
  ChatListRepository reposatory;

  DeletMessageUsecase(this.reposatory);

  @override
  Future<bool> call(DeletMessageParams params, BuildContext context) async {
    try {
     final deletedMessage =  await reposatory.deletMessage(params.senderId, params.reciverId,params.messageId);
     if (deletedMessage== true) {
       return true ;
     }else{
      return false;
     }

    } catch (e) {
        return false;
    }
  }
}

class DeletMessageParams {
   String senderId;
   String reciverId;
   String messageId;


  DeletMessageParams({
    required this.senderId,
    required this.reciverId,
    required this.messageId,
  });
}