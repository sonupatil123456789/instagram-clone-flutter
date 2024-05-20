// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

import '../../domain/entity/TagPeopleEntity.dart';

@immutable
class PostState {
  // UserEntity? userModel;
  List<TagPeopleEntity> tagPeoples = [];
  List<String> hashTags = [];
  CurrentAppState? currentState;
  // UserStatusEntity userStatus ;

  PostState({
    this.currentState,
    // required this.userStatus,
    required this.hashTags,
    required this.tagPeoples,
  });

  PostState copyWith({
    List<TagPeopleEntity>? tagPeoples,
    List<String>? hashTags,
    // UserStatusEntity? userStatus ,
    CurrentAppState? currentState,
  }) {
    return PostState(
        currentState: currentState ?? this.currentState,
        tagPeoples: tagPeoples ?? this.tagPeoples,
        // userStatus: userStatus ?? this.userStatus,
        hashTags: hashTags ?? this.hashTags);
  }
}
