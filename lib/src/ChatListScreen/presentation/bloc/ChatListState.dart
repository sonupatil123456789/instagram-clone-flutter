// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';



@immutable
class ChatListState {

  StreamController<List<UserChatMessageEntity>> chatStreamController;

  ChatListState({required this.chatStreamController});



  

}
