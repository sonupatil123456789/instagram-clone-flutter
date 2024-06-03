import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';

import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/DiscoverScreen/domain/use_cases/followUserUsecase.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/use_cases/GetOtherUserDetailsStreamUsecase.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/use_cases/GetOtherUserPostsUsecase.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

import '../../domain/use_cases/GetOthersUserDetailsUsecase.dart';
import 'OtherUserEvent.dart';
import 'OtherUserState.dart';

class OtherUserBloc extends Bloc<OtherUserEvent, OtherUserState> {
  GetOtherUserDetailsUsecase getOtherUserDetails;
  GetOtherUserDetailsStreamUsecase getOtherUserDetailsStream ;
  GetOtherUserPostsUsecase getOtherUserPosts ;
  FollowUserUsecase followUser;




  OtherUserBloc({
    required this.getOtherUserDetailsStream,
    required this.getOtherUserDetails,
    required this.getOtherUserPosts,
    required this.followUser,
  
  })
    : super(OtherUserState(postList: const [], otherUserDetailsStream:  StreamController<UserEntity>.broadcast(), otherUserDetails: UserModel(), 
    currentState: CurrentAppState.INITIAL, isUserFollowing: false,)) {
           on<GetOtherUserDetailDataEvent>(_getOtherUserDetailDataEvent);
           on<FollowOtherUserEvent>(_followUserEvent);
  }

  _getOtherUserDetailDataEvent(GetOtherUserDetailDataEvent event , Emitter<OtherUserState> emit)async {
    try {
      emit(state.copyWith(currentState: CurrentAppState.LOADING));
     final data = await Future.wait([
      getOtherUserDetails.call(event.uuid, event.context),
      getOtherUserPosts.call(event.uuid, event.context),
     ]);

     final UserEntity userData = data[0] as UserEntity ;

    final isFollowing =  userData.followers!.contains(event.followingOther);

    emit(state.copyWith(currentState: CurrentAppState.SUCCESS, otherUserDetails:userData, postList: data[1] as List<PostEntity> , isUserFollowing: isFollowing));
    } catch (error) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }

  }



  

  getAllFriendsPostStreamEvent(BuildContext context, String uuid) {
    try {
        getOtherUserDetailsStream.call(uuid,context).listen((event) {
          state.otherUserDetailsStream.sink.add(event);
        }).onError((error) {
          state.otherUserDetailsStream.sink.addError(error);
        });
    } catch (error) {
      state.otherUserDetailsStream.sink.addError(error);
    }
  }


   _followUserEvent(FollowOtherUserEvent event, Emitter<OtherUserState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await followUser.call(FollowUserParams(following: event.following),event.context);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, isUserFollowing: data));
        } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR,));
    }
  }






}
