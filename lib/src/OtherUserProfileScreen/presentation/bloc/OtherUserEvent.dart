// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


abstract class OtherUserEvent {}



class GetOtherUserDetailDataEvent extends OtherUserEvent{
  BuildContext context;
  String uuid ;
  FollowEntity followingOther;



  GetOtherUserDetailDataEvent({
    required this.context,
    required this.uuid,
    required this.followingOther,
  });

  
}
class FollowOtherUserEvent extends OtherUserEvent{
  BuildContext context;
  FollowEntity following ;

  FollowOtherUserEvent({
    required this.context,
    required this.following,
  });


}


