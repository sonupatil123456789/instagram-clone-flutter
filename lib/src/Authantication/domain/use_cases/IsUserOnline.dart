import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import '../auth_repository/auth_repository.dart';

class IsOnlineUsecase implements UseCase<void, bool> {
  AuthRepository repository;

  IsOnlineUsecase(this.repository);

  @override
  Future<void> call(bool isOnline, BuildContext context) async {
    try {
       repository.isUserOnline(isOnline);
       ListnersUtils.showToastMessage(isOnline == true ? "Online" : "Offline", Colors.black38);
    } on Exception catch (error) {
       
    }
  }
}
