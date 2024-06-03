import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../auth_repository/auth_repository.dart';

class ResetPasswordUsecase implements UseCase<void, String> {
  AuthRepository repository;

  ResetPasswordUsecase(this.repository);

  @override
  Future<void> call(String email, BuildContext context) async {
    try {
      repository.resetPassword(email);
          ListnersUtils.showFlushbarMessage(
          "Reset password email send to yours registered email id ",
          errorColor,
          white,
          "Password Reset Email Sent",
          Icons.error,
          context);
    } on Exception {
      ListnersUtils.showFlushbarMessage(
          "Fail to send reset password mail . Please Try After Some Time",
          errorColor,
          white,
          "Fail To Send Email",
          Icons.error,
          context);
    }
  }
}
