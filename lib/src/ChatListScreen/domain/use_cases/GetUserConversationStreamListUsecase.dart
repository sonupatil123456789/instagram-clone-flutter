
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import '../repository/repository.dart';

class GetUserConversationStreamListUsecase implements StreamedUseCase<Stream<List<UserChatMessageEntity>>, GetUserConversationStreamListParams> {
  ChatListRepository repository;

  GetUserConversationStreamListUsecase(this.repository);

  @override
    Stream<List<UserChatMessageEntity>> call(GetUserConversationStreamListParams params , BuildContext context)  {
    try {
      return repository.getUserConversationStreamList(params.senderId , params.reciverId);
    } catch (error) {
      rethrow ;
    }
  }
}

class GetUserConversationStreamListParams{
  String senderId ;
  String reciverId ;

  GetUserConversationStreamListParams({required this.senderId , required this.reciverId});
}


