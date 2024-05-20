
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import '../repository/repository.dart';

class GetAllFriendsChattingUserStreamListUsecase implements StreamedUseCase<Stream<List<UserEntity>>, List<FollowEntity>> {
  ChatListRepository repository;

  GetAllFriendsChattingUserStreamListUsecase(this.repository);

  @override
    Stream<List<UserEntity>> call(List<FollowEntity> following , BuildContext context)  {
    try {
      return repository.getAllFriendsChattingStreamList(following);
    } catch (error, stack) {
      rethrow ;
    }
  }
}


