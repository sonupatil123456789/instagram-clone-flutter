


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ReplyedToEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class HomeState extends Equatable {
  CurrentAppState? currentState;
  List<PostEntity>? postList = [];
  List<CommentsEntity>? replayCommentList = [];
  CommentsEntity? comment;
  ReplyedTo? replyedTo;



  HomeState({
    this.currentState,
    required this.replyedTo,
    required this.comment,
    required this.replayCommentList,
    required this.postList,
  });

  HomeState copyWith({
    CurrentAppState? currentState,
    List<PostEntity>?  postList,
    List<CommentsEntity>?  replayCommentList,
    CommentsEntity? comment,
    ReplyedTo? replyedTo,
  }) {
    return HomeState(
      currentState: currentState ?? this.currentState,
      postList: postList ?? this.postList,
      replayCommentList: replayCommentList ?? this.replayCommentList,
      comment: comment ?? this.comment,
      replyedTo: replyedTo ?? this.replyedTo,
    );
  }



  @override
  List<Object?> get props => [currentState , replayCommentList,postList,postList, comment];
}
