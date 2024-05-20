import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import '../../../../core/firebaseServices/firebaseExceptions.dart';
import '../auth_repository/auth_repository.dart';

class GetUserStreamListUsecase implements StreamedUseCase<Stream<List<UserEntity>?>?, String> {
  AuthRepository repository;

  GetUserStreamListUsecase(this.repository);

  @override
    Stream<List<UserEntity>?>? call(String  searchQuery, BuildContext context)  {
    try {
      return repository.getAllUserStreamList(searchQuery);
    } on FirebaseAuthException catch (error, stack) {
      CoustomFirebaseException().firebasePhoneAuthExceptionHandler(context, error.code);
      return null;
    } catch (error, stack) {
       return null;
    }
  }
}


