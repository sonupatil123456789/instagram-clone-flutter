// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

import '../../domain/entity/TagPeopleEntity.dart';

@immutable
class PostState {
  // UserEntity? userModel;
  List<TagPeopleEntity> tagPeoples = [];
  List<String> hashTags = [];
  CurrentAppState? currentState;
  StreamController<List<UserStatusEntity>> friendsStatusListStream ;
  UserStatusEntity userStatus ;

  PostState({
    this.currentState,
    required this.userStatus,
    required this.hashTags,
    required this.tagPeoples,
    required this.friendsStatusListStream,
  });

  PostState copyWith({
    List<TagPeopleEntity>? tagPeoples,
    List<String>? hashTags,
     StreamController<List<UserStatusEntity>>? friendsStatusListStream ,
    CurrentAppState? currentState,
    UserStatusEntity? userStatus  
  }) {
    return PostState(
        currentState: currentState ?? this.currentState,
        tagPeoples: tagPeoples ?? this.tagPeoples,
        userStatus: userStatus ?? this.userStatus,
        friendsStatusListStream: friendsStatusListStream ?? this.friendsStatusListStream,
        hashTags: hashTags ?? this.hashTags);
  }
}
