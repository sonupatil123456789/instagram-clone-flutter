// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ReplyedToEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';

abstract class BookmarkEvent {}






class GetAllBookmarkEvent extends BookmarkEvent{
  BuildContext context;
  bool isRefresh;

  GetAllBookmarkEvent({
    required this.context,
    required this.isRefresh,
  });
}


class DeletBookmarkEvent extends BookmarkEvent {
  String bookmarkId;
  BuildContext context;


  DeletBookmarkEvent({
    required this.bookmarkId,
    required this.context,
  });
}

class AddBookmarkEvent extends BookmarkEvent {
  PostEntity bookmark;
  BuildContext context;


  AddBookmarkEvent({
    required this.bookmark,
    required this.context,
  });
}



