import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/auth_repository/auth_repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class LogOutUsecase implements UseCase<bool, EmptyParams> {
  AuthRepository reposatory;

  LogOutUsecase(this.reposatory);
                                                                       
  @override
  Future<bool> call(EmptyParams params, BuildContext context) async {
    try {
      final signedOut = await reposatory.signeOutUser();
      if (signedOut) {
        Navigator.pushNamedAndRemoveUntil(context,RoutesName.loginUserScreen, (route) => false);
        return true ;    
      } else {
        throw "Unable To SigneOut";
      }
    } catch (e) {
      ListnersUtils.showFlushbarMessage(
          e.toString(),
          errorColor,
          white,
          "Error",
          Icons.error,
          context);
      return false ;
    }
  }
}


