// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';

import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

@immutable
class DiscoverState extends Equatable {
  late FollowEntity follow = FollowModel() ;
  CurrentAppState? currentState;

  DiscoverState({
    this.currentState,
    required this.follow,
  });

  DiscoverState copyWith({
    CurrentAppState? currentState,
    FollowEntity? follow
  }) {
    return DiscoverState(
        currentState: currentState ?? this.currentState,
        follow: follow ?? this.follow,
       );
  }



  @override
  List<Object?> get props => [follow, currentState];
}
