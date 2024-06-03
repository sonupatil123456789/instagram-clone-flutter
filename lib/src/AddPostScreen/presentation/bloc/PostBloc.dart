import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/GetAllStatusUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/GetMyStatusUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/IsStatusViewed.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/UploadPostsUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/UploadStatusUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostEvents.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostState.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';

import '../../domain/entity/TagPeopleEntity.dart';

class PostBloc extends Bloc<PostEvents, PostState> {
  UploadPostsUsecase uploadPost;
  UploadStatusUsecase uploadStatus;
  IsStatusViewedUsecase isStatusViewed;
  GetAllStatusUsecase getAllStatus;
  GetMyStatusUsecase getMyStatus;

  List<TagPeopleEntity> tagPeoples = [];
  List<String> hashTags = [];

  PostBloc({
    required this.uploadPost,
    required this.uploadStatus,
    required this.isStatusViewed,
    required this.getAllStatus,
    required this.getMyStatus,
    })
      : super(PostState(
            currentState: CurrentAppState.INITIAL,
            hashTags: const [],
            tagPeoples: const [], friendsStatusListStream:  StreamController<List<UserStatusEntity>>.broadcast(), userStatus: UserStatusEntity(),)) {
    on<TagPeopleEvent>(_tagUserEvent);
    on<HashTagEvent>(_hashTagEvent);
    on<UploadPostEvent>(_uploadPostEvent);
    on<UploadStatusEvent>(_uploadStatusEvent);
    on<IsStatusViewedEvent>(_isStatusViewedEvent);
    on<GetMyStatusEvent>(_getMyStatusEvent);
  }

  _tagUserEvent(TagPeopleEvent event, Emitter<PostState> emit) {
    if (tagPeoples.contains(event.tagPeoples) == true) {
      tagPeoples.remove(event.tagPeoples);
    } else {
      tagPeoples.add(event.tagPeoples);
    }
    CoustomLog.coustomLogData("Tagged people", tagPeoples);
    emit(state.copyWith(tagPeoples: tagPeoples));
  }

  _hashTagEvent(HashTagEvent event, Emitter<PostState> emit) {
    if (hashTags.contains(event.hashTags)) {
      hashTags.remove(event.hashTags);
    } else {
      hashTags.add(event.hashTags);
    }
    CoustomLog.coustomLogData("Hash Tag ", hashTags);
    emit(state.copyWith(hashTags: hashTags));
  }

  _uploadPostEvent(UploadPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
         final blocPost = UploadPostsParams(
          postImageFileType: event.fileData.coustomfileType.enumToString(),
          postImage: event.fileData.fileData.path,
          profileImage:event.profileImage,
          tagPeople: state.tagPeoples,
          location: event.location,
          postDiscription: event.discription,
          tags: state.hashTags,
          uniqueName: event.uniqueName
        );
        
    final post = await uploadPost.call(blocPost , event.context);

    if (post != null) { 
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, tagPeoples: [] , hashTags: []));
      tagPeoples.clear();
      hashTags.clear();
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }
  _uploadStatusEvent(UploadStatusEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
         final blocStatus = UploadStatusParams(
         statusImage: event.fileData.fileData.path,
         statusImageFileType: event.fileData.coustomfileType.enumToString(),
         statusDiscription: event.discription,
         tagPeople: state.tagPeoples,
         );
        
    final status = await uploadStatus.call(blocStatus , event.context);

    if (status == true) { 
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, tagPeoples: []));
      tagPeoples.clear();
      hashTags.clear();
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }
  _isStatusViewedEvent(IsStatusViewedEvent event, Emitter<PostState> emit) async {
    final status = await isStatusViewed.call(IsStatusViewedParams(event.userId, event.isStatusViewed), event.context);
  }


  _getMyStatusEvent(GetMyStatusEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    final status = await getMyStatus.call(EmptyParams(),event.context);
    if (status != null) { 
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, userStatus: status));
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }


  getFollowersStatusStreamEvent(context, List<FollowEntity> followers) {
     try {
      if (followers.isNotEmpty) {
        getAllStatus.call(followers, context).listen((event) {
          state.friendsStatusListStream.sink.add(event);
        }).onError((error) {
          state.friendsStatusListStream.sink.addError(error);
        });
      }
      state.friendsStatusListStream.sink.add([]);
    } catch (error) {
      state.friendsStatusListStream.sink.addError(error);
    }
  }


  
 



}
