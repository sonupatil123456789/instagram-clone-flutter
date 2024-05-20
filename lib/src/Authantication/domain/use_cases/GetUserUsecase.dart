import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import '../auth_repository/auth_repository.dart';

class GetUserUsecase implements UseCase<UserEntity, bool> {
  AuthRepository repository;

  GetUserUsecase(this.repository);

  @override
  Future<UserEntity> call(bool isRefresh, BuildContext context) async {
    try {
      return await repository.getUser(isRefresh);
    } on FirebaseException catch (error, stack) {
       rethrow;
    } catch (error, stack) {
       rethrow;
    }
  }
}
