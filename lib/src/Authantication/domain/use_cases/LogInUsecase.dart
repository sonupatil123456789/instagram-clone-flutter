import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import '../../../../core/firebaseServices/firebaseExceptions.dart';
import '../auth_repository/auth_repository.dart';

class LoginUsecase implements UseCase<UserEntity?, LogInParams> {
  AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  Future<UserEntity?> call(LogInParams params, BuildContext context) async {
    try {
      var data = await repository.logInWithEmailIdPassword(params);
      Navigator.pushNamedAndRemoveUntil(context,RoutesName.mainSectionScreen, (route) => false);
          return data;
    } on FirebaseAuthException catch (error) {
      CoustomFirebaseException().firebasePhoneAuthExceptionHandler(context, error.code);
      return null;
    } catch (error) {
       return null;
    }
  }
}

class LogInParams extends UserEntity {

  @override
  String? password;
  @override
  String? email;

  LogInParams({
    this.password,
    this.email,
  });
}
