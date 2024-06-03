
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import '../auth_repository/auth_repository.dart';

class GetUserStreamListUsecase implements StreamedUseCase<Stream<List<UserEntity>>, String> {
  AuthRepository repository;

  GetUserStreamListUsecase(this.repository);

  @override
    Stream<List<UserEntity>> call(String  searchQuery, BuildContext context)  {
    try {
      return repository.getAllUserStreamList(searchQuery);
    } catch (error, stack) {
       rethrow ;
    }
  }
}


