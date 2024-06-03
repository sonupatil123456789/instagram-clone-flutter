
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserMessageListEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import '../repository/repository.dart';

class GetAllFriendsChattingUserStreamListUsecase implements StreamedUseCase<Stream<List<UserMessageListEntity>>, List<FollowEntity>> {
  ChatListRepository repository;

  GetAllFriendsChattingUserStreamListUsecase(this.repository);

  @override
    Stream<List<UserMessageListEntity>> call(List<FollowEntity> following , BuildContext context)  {
    try {
      return repository.getAllFriendsChattingStreamList(following);
    } catch (error) {
      rethrow ;
    }
  }
}


