// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class ReelState extends Equatable {
  CurrentAppState? currentState;
  List<PostEntity>? videoPostList = [];


  ReelState({
    this.currentState,
    required this.videoPostList,
  });

  ReelState copyWith({
    CurrentAppState? currentState,
     List<PostEntity>?  videoPostList
  }) {
    return ReelState(
      currentState: currentState ?? this.currentState,
      videoPostList: videoPostList ?? this.videoPostList,
    );
  }



  @override
  List<Object?> get props => [currentState];
}
