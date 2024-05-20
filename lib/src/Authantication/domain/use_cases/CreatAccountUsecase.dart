
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import '../../../../core/firebaseServices/firebaseExceptions.dart';
import '../auth_repository/auth_repository.dart';

class CreatAccountUsecase implements UseCase<UserEntity?, CreatAccountParams> {
  AuthRepository repository;

  CreatAccountUsecase(this.repository);

  @override
  Future<UserEntity?> call(
      CreatAccountParams params, BuildContext context) async {
    try {
      var data = repository.creatAcountWithEmailIdPassword(params);
      if (data != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.mainSectionScreen, (route) => false);
      }
      return data;
    } on FirebaseAuthException catch (error, stack) {
      CoustomFirebaseException()
          .firebasePhoneAuthExceptionHandler(context, error.code);
      return null;
    } catch (error, stack) {
      return null;
    }
  }
}

class CreatAccountParams extends UserEntity {
  String? uniqueName;
  String? userName;
  String? password;
  String? email;
  String? phoneNumber;
  CreatAccountParams({
    this.uniqueName,
    this.userName,
    this.password,
    this.email,
    this.phoneNumber,
  });
}
