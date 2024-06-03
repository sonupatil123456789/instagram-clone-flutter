


import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';


@immutable
class OtherUserState extends Equatable {
  List<PostEntity> postList = [];
  UserEntity otherUserDetails; 
  CurrentAppState currentState;
  StreamController<UserEntity> otherUserDetailsStream ;
  bool isUserFollowing = false  ;



  OtherUserState({
    required this.postList,
    required this.isUserFollowing,
    required this.otherUserDetails,
    required this.currentState,
    required this.otherUserDetailsStream,
  });

  OtherUserState copyWith({
  List<PostEntity> ? postList ,
  UserEntity? otherUserDetails ,
   CurrentAppState? currentState ,
   bool? isUserFollowing ,
  StreamController<UserEntity>?  otherUserDetailsStream ,
  }) {
    return OtherUserState(
      otherUserDetailsStream: otherUserDetailsStream ?? this.otherUserDetailsStream,
     postList: postList ?? this.postList, 
      otherUserDetails: otherUserDetails ?? this. otherUserDetails, 
      currentState: currentState ?? this.currentState,
       isUserFollowing: isUserFollowing ?? this. isUserFollowing 
    );
  }



  @override
  List<Object?> get props => [otherUserDetailsStream ,postList ,  otherUserDetails , currentState , ];
}
