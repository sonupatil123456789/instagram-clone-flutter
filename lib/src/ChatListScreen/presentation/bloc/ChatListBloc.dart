import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/GetAllFriendsChattingUserStreamListUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/GetUserConversationStreamListUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/SendMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/ViewedMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListEvents.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListState.dart';

class ChatListBloc extends Bloc<ChatListEvents, ChatListState> {
  GetAllFriendsChattingUserStreamListUsecase getFriendsChattingUserList;
  SendMessageUsecase sendMessage;
  ViewedMessageUsecase viewedMessage ;
  GetUserConversationStreamListUsecase getUserConversationStreamList;

  ChatListBloc(
      {required this.getFriendsChattingUserList,
      required this.sendMessage,
      required this.viewedMessage,
      required this.getUserConversationStreamList})
      : super(ChatListState(
            chatStreamController:
                StreamController<List<UserChatMessageEntity>>.broadcast())) {
    on<SendMessageEvent>(_sendMessageEvent);
    on<ViewedMessageEvent>(_viewedMessageEvent);
  }

  Stream<List<UserEntity>> getFollowersStatusStreamEvent(
      context, List<FollowEntity> followers) {
    if (followers.isNotEmpty) {
      return getFriendsChattingUserList.call(followers, context);
    }
    return const Stream.empty();
  }

  _sendMessageEvent(SendMessageEvent event, Emitter<ChatListState> emit) async {
    await sendMessage.call(
        SendMessageParams(
            sender: event.sender,
            reciver: event.reciver,
            messageData: event.messageData),
        event.context);
  }

  _viewedMessageEvent(ViewedMessageEvent event, Emitter<ChatListState> emit) async {
    await viewedMessage.call(ViewedMessageParams(senderId: event.senderId, reciverId:event. reciverId, messageId:event. messageId), event.context);
  }

  getUserConversationStreamListEvent(
      String senderId, String reciverId, BuildContext context) {
    try {
      getUserConversationStreamList.call(GetUserConversationStreamListParams(senderId: senderId, reciverId: reciverId),context).listen((event) {
        state.chatStreamController.sink.add(event);
      }).onError((error) {
        state.chatStreamController.sink.addError(error);
      });
    } catch (error) {
      state.chatStreamController.sink.addError(error);
    }
  }

// try {
//     final statusList = await fetchStatusFromAPI(userId);
//     _statusStreamController.sink.add(statusList);
//   } catch (e) {
//     _statusStreamController.sink.addError(e);
//   }
}
