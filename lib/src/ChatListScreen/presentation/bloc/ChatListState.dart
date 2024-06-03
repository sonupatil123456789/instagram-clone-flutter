// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserMessageListModel.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserMessageListEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';



@immutable
class ChatListState {

  StreamController<List<UserChatMessageEntity>> chatStreamController;
  StreamController<List<UserMessageListEntity>> userChatList ;
   CurrentAppState? currentState;

  ChatListState({required this.chatStreamController, required this.currentState, required this.userChatList });

  ChatListState copyWith({
    CurrentAppState? currentState,
    StreamController<List<UserChatMessageEntity>>? chatStreamController,
    StreamController<List<UserMessageListModel>>? userChatList 
  }) {
    return ChatListState(
      currentState: currentState ?? this.currentState,
       chatStreamController: chatStreamController ?? this.chatStreamController,
       userChatList: userChatList ?? this.userChatList,
    );
  }


}



