// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ReplyedToEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';

abstract class HomeEvent {}



class GetAllFriendsPostEvent extends HomeEvent{
  BuildContext context;
  List<FollowEntity> following;
  bool isRefresh;

  GetAllFriendsPostEvent({
    required this.context,
    required this.following,
    required this.isRefresh,
  });
}
class GetAllPostEvent extends HomeEvent{
  BuildContext context;
  bool isRefresh;

  GetAllPostEvent({
    required this.context,
    required this.isRefresh,
  });
}
class LikePostEvent extends HomeEvent{
  BuildContext context;
  LikesEntity likePost;
  String postId;

  LikePostEvent({
    required this.context,
    required this.likePost,
    required this.postId,
  });
}

class PostCommentReplyEvent extends HomeEvent {
  CommentsEntity comment;
  BuildContext context;
  String postId;

  PostCommentReplyEvent({
    required this.comment,
    required this.postId,
    required this.context,
  });
}

class DeletCommentReplyEvent extends HomeEvent {
  String commentId;
  BuildContext context;
  String postId;

  DeletCommentReplyEvent({
    required this.commentId,
    required this.postId,
    required this.context,
  });
}


class SetComment extends HomeEvent {
  CommentsEntity? comment;
  SetComment({
     this.comment,
  });
}
class SetReplay extends HomeEvent {
  ReplyedTo? replay;
  SetReplay({
     this.replay,
  });
}

