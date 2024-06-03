import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/DeletCommentReplyUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllFriendsPostUsecase.dart.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllPostCommentsStreamUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllPostUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/LikePostUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/PostCommentReplyUsecase.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import '../../domain/use_cases/GetAllFriendsPostStreamUsecase.dart';
import '../../domain/use_cases/GetAllPostStreamUsecase.dart';
import 'HomeEvent.dart';
import 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetAllFriendsPostUsecase getAllFriendsPost;
  GetAllPostUsecase getAllPost;
  GetAllFriendsPostStreamUsecase getAllFriendsPostStream;
  GetAllPostStreamUsecase getAllPostStream;
  LikePostUsecase likePost;
  GetAllPostCommentsStreamUsecase getAllPostCommentsStream;
  PostCommentReplyUsecase postCommentReply;
  DeletCommentReplyUsecase deletCommentReply;


  HomeBloc(
      {required this.getAllFriendsPost,
      required this.getAllPost,
      required this.getAllFriendsPostStream,
      required this.getAllPostStream,
      required this.likePost,
      required this.getAllPostCommentsStream,
      required this.postCommentReply,
      required this.deletCommentReply})
      : super(HomeState(
          currentState: CurrentAppState.INITIAL,
          postList: const [],
          replayCommentList: const [], replyedTo: null, comment: null, postListStream: StreamController<List<PostEntity>>.broadcast(),
           postCommentListStream: StreamController<List<CommentsEntity>>.broadcast(),
        )) {

          
    on<GetAllFriendsPostEvent>(_getAllFriendsPostEvent);
    on<GetAllPostEvent>(_getAllPostEvent);
    on<LikePostEvent>(_likePostEvent);
    on<PostCommentReplyEvent>(_postCommentReplyEvent);
    on<DeletCommentReplyEvent>(_deletCommentReplyEvent);

    on<SetComment>(_setComment);
    on<SetReplay>(_setReplay);
  }

  _getAllFriendsPostEvent(
      GetAllFriendsPostEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await getAllFriendsPost.call(
          GetAllFriendsPostParams(
              following: event.following, isRefresh: event.isRefresh),
          event.context);
      emit(state.copyWith(
          currentState: CurrentAppState.SUCCESS, postList: data));
    } catch (e) {
      emit(state.copyWith(
        currentState: CurrentAppState.ERROR,
      ));
    }
  }

  _getAllPostEvent(GetAllPostEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await getAllPost.call(
          GetAllPostParams(isRefresh: event.isRefresh), event.context);
      emit(state.copyWith(
          currentState: CurrentAppState.SUCCESS, postList: data));
    } catch (e) {
      emit(state.copyWith(
        currentState: CurrentAppState.ERROR,
      ));
    }
  }

  getAllFriendsPostStreamEvent(BuildContext context, List<FollowEntity>? following, bool isRefresh) {
    try {
      if (following != [] || following != null) {
        getAllFriendsPostStream.call(GetAllFriendsPostParams(following: following ?? [], isRefresh: isRefresh),context).listen((event) {
          state.postListStream.sink.add(event);
        }).onError((error) {
          state.postListStream.sink.addError(error);
        });
      }
       state.postListStream.sink.add([]);
    } catch (error) {
      state.postListStream.sink.addError(error);
    }
  }

   getAllPostCommmentsStreamEvent(context, String postId) {
      try {
     getAllPostCommentsStream.call(postId, context).listen((event) {
          state.postCommentListStream.sink.add(event);
        }).onError((error) {
          state.postCommentListStream.sink.addError(error);
        });
    } catch (error) {
      state.postCommentListStream.sink.addError(error);
    }
  }

  _likePostEvent(LikePostEvent event, Emitter<HomeState> emit) async {
    await likePost.call(
        LikePostParams(likePost: event.likePost, postId: event.postId),
        event.context);
  }

  _postCommentReplyEvent(PostCommentReplyEvent event, Emitter<HomeState> emit) async {
     CoustomLog.coustomLogData("Comment",event.comment.toString());
    await postCommentReply.call(PostCommentReplyParams(postId: event.postId, comment: event.comment),event.context);
  }

  _deletCommentReplyEvent(DeletCommentReplyEvent event, Emitter<HomeState> emit) async {
    await deletCommentReply.call(DeletCommentReplyParams(commentId: event.commentId, postId: event.postId),event.context);
  }


  _setComment( SetComment event, Emitter<HomeState> emit)  {
    CoustomLog.coustomLogData("nestedComment",event.comment.toString());
    emit(state.copyWith(comment: event.comment));
  }

  _setReplay( SetReplay event, Emitter<HomeState> emit)  {
     CoustomLog.coustomLogData("nestedReplay",event.replay.toString());
    emit(state.copyWith(replyedTo: event.replay));
  }



}
