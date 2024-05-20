import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


abstract class DiscoverEvent {}



class FollowUserEvent extends DiscoverEvent{
  BuildContext context;
  FollowEntity following;

  FollowUserEvent({
    required this.context,
    required this.following,
  });
}

