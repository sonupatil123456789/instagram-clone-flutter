// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class AuthState extends Equatable {
  UserEntity userModel ;
  CurrentAppState? currentState;
  // CurrentAppState? loadingState;
  StreamController<List<UserEntity>> userListStream ;


  AuthState({ 
     required this.userModel,
    this.currentState,
     required this.userListStream ,
    // this.loadingState ,
      });

  AuthState copyWith({
    UserEntity? userModel,
    CurrentAppState? currentState,
    StreamController<List<UserEntity>>? userListStream 
  }) {
  
    return AuthState(
      userModel: userModel ?? this.userModel,
      currentState: currentState ?? this.currentState,
      userListStream: userListStream ?? this.userListStream,
    );
  }

  @override
  List<Object?> get props => [userModel, currentState,userListStream ];
}
