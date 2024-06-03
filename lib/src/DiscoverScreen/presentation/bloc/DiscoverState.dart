// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class DiscoverState extends Equatable {
  // late FollowEntity follow = FollowModel() ;
  CurrentAppState? currentState;
  bool isFollowing ;

  DiscoverState({
    this.currentState,
    // required this.follow,
    required this.isFollowing,
  });

  DiscoverState copyWith({
    CurrentAppState? currentState,
    // FollowEntity? follow,
    bool? isFollowing
  }) {
    return DiscoverState(
        currentState: currentState ?? this.currentState,
        // follow: follow ?? this.follow, 
        isFollowing: isFollowing ?? this.isFollowing,
       );
  }



  @override
  List<Object?> get props => [ currentState , isFollowing];
}
