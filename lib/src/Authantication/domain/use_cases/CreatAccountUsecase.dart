
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
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.mainSectionScreen, (route) => false);
          return data;
    } on FirebaseAuthException catch (error) {
      CoustomFirebaseException()
          .firebasePhoneAuthExceptionHandler(context, error.code);
      return null;
    } catch (error) {
      return null;
    }
  }
}

class CreatAccountParams extends UserEntity {
  @override
  String? uniqueName;
  @override
  String? userName;
  @override
  String? password;
  @override
  String? email;
  @override
  String? phoneNumber;
  CreatAccountParams({
    this.uniqueName,
    this.userName,
    this.password,
    this.email,
    this.phoneNumber,
  });
}
