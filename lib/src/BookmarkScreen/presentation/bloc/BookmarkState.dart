

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class BookmarkState extends Equatable {
  CurrentAppState? currentState;
  List<PostEntity>? bookmarkList = [];



  BookmarkState({
    this.currentState,
    this.bookmarkList,
  });

  BookmarkState copyWith({
    CurrentAppState? currentState,
    List<PostEntity>?  bookmarkList,
  }) {
    return BookmarkState(
      currentState: currentState ?? this.currentState,
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }



  @override
  List<Object?> get props => [currentState , bookmarkList];
}
