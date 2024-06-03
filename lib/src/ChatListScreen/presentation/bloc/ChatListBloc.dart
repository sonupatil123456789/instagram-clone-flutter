import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserMessageListEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/DeletMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/GetAllFriendsChattingUserStreamListUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/GetUserConversationStreamListUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/SendMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/ViewedLastMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/ViewedMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListEvents.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

class ChatListBloc extends Bloc<ChatListEvents, ChatListState> {
  GetAllFriendsChattingUserStreamListUsecase getFriendsChattingUserList;
  SendMessageUsecase sendMessage;
  ViewedMessageUsecase viewedMessage;
  ViewedLastMessageUsecase viewedLastMessage;
  GetUserConversationStreamListUsecase getUserConversationStreamList;
  DeletMessageUsecase deletMessage;

  ChatListBloc(
      {required this.getFriendsChattingUserList,
      required this.sendMessage,
      required this.viewedMessage,
      required this.viewedLastMessage,
      required this.deletMessage,
      required this.getUserConversationStreamList})
      : super(ChatListState(
          chatStreamController:StreamController<List<UserChatMessageEntity>>.broadcast(),
          currentState: CurrentAppState.INITIAL,
          userChatList: StreamController<List<UserMessageListEntity>>.broadcast(),
        )) {
    on<SendMessageEvent>(_sendMessageEvent);
    on<ViewedMessageEvent>(_viewedMessageEvent);
    on<ViewedLastMessageEvent>(_viewedLastMessageEvent);
    on<DeletMessageEvent>(_deletMessageEvent);
  }

  getFriendsChattingUserListStreamEvent(context, List<FollowEntity> followers) {
    try {
      if (followers.isNotEmpty) {
        getFriendsChattingUserList.call(followers, context).listen((event) {
          state.userChatList.sink.add(event);
        }).onError((error) {
          state.userChatList.sink.addError(error);
        });
      }
      state.userChatList.sink.add([]);
    } catch (error) {
      state.userChatList.sink.addError(error);
    }

  }

  _sendMessageEvent(SendMessageEvent event, Emitter<ChatListState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));

    await sendMessage.call(
        SendMessageParams(
            sender: event.sender,
            reciver: event.reciver,
            messageData: event.messageData),
        event.context);

    emit(state.copyWith(currentState: CurrentAppState.SUCCESS));
  }

  _viewedMessageEvent(
      ViewedMessageEvent event, Emitter<ChatListState> emit) async {
    await viewedMessage.call(
        ViewedMessageParams(
            senderId: event.senderId,
            reciverId: event.reciverId,
            messageId: event.messageId),
        event.context);
  }

  _viewedLastMessageEvent(
      ViewedLastMessageEvent event, Emitter<ChatListState> emit) async {
    await viewedLastMessage.call(
        ViewedLastMessageParams(
            senderId: event.senderId,
            reciverId: event.reciverId,),
        event.context);
  }

  _deletMessageEvent(DeletMessageEvent event, Emitter<ChatListState> emit) async {
    await deletMessage.call(
        DeletMessageParams(
            senderId: event.senderId,
            reciverId: event.reciverId,
            messageId: event.messageId),
        event.context);
  }

  getUserConversationStreamListEvent(
      String senderId, String reciverId, BuildContext context) {
    try {
      getUserConversationStreamList.call(
              GetUserConversationStreamListParams( senderId: senderId, reciverId: reciverId),
              context)
          .listen((event) {
        state.chatStreamController.sink.add(event);
      }).onError((error) {
        state.chatStreamController.sink.addError(error);
      });
    } catch (error) {
      state.chatStreamController.sink.addError(error);
    }
  }
}
