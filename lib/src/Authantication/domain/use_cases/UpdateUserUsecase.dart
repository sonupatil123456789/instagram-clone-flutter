import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/auth_repository/auth_repository.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class UpdateUserUsecase implements UseCase<bool, UserEntity> {
  AuthRepository reposatory;

  UpdateUserUsecase(this.reposatory);
                                                                       
  @override
  Future<bool> call(UserEntity user, BuildContext context) async {
    try {
      final userUpdated = await reposatory.updateUserInformation(user);
      if (userUpdated) {
        Navigator.pop(context);
        return true;    
      } else {
        throw "Unable To Update User Information";
      }
    } catch (e) {
       ListnersUtils.showFlushbarMessage("Some error occured please check you internrt connection or try to open app after some time ",
          errorColor,
          white,
          "Unable To Update User Info",
          Icons.error,
          context);
      return false ;
    }
  }
}


