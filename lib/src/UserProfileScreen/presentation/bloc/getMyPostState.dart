// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class UserProfileState extends Equatable {
  CurrentAppState? currentState;
  List<PostEntity>? myPostList = [];


  UserProfileState({
    this.currentState,
    required this.myPostList,
  });

  UserProfileState copyWith({
    CurrentAppState? currentState,
     List<PostEntity>?  myPostList
  }) {
    return UserProfileState(
      currentState: currentState ?? this.currentState,
      myPostList: myPostList ?? this.myPostList,
    );
  }



  @override
  List<Object?> get props => [currentState];
}
