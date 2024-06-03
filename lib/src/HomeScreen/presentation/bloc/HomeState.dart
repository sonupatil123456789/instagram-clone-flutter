


import 'dart:async';

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
  StreamController<List<PostEntity>> postListStream ;
  StreamController<List<CommentsEntity>> postCommentListStream ;



  HomeState({
    this.currentState,
    required this.replyedTo,
    required this.comment,
    required this.replayCommentList,
    required this.postList,
    required this.postListStream,
    required this.postCommentListStream,
  });

  HomeState copyWith({
    CurrentAppState? currentState,
    List<PostEntity>?  postList,
    List<CommentsEntity>?  replayCommentList,
    CommentsEntity? comment,
    ReplyedTo? replyedTo,
     StreamController<List<PostEntity>>? postListStream ,
     StreamController<List<CommentsEntity>>? postCommentListStream 
  }) {
    return HomeState(
      currentState: currentState ?? this.currentState,
      postList: postList ?? this.postList,
      replayCommentList: replayCommentList ?? this.replayCommentList,
      comment: comment ?? this.comment,
      replyedTo: replyedTo ?? this.replyedTo,
       postListStream: postListStream ?? this.postListStream,
       postCommentListStream: postCommentListStream ?? this.postCommentListStream,
    );
  }



  @override
  List<Object?> get props => [currentState , replayCommentList,postList,postList, comment];
}
