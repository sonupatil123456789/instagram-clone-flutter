
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class GetOtherUserDetailsUsecase implements UseCase<UserEntity, String>{
  OtherUserRepository reposatory;

  GetOtherUserDetailsUsecase(this.reposatory);
  @override
  Future<UserEntity>  call(String uuid, BuildContext context) {

    try {
      return reposatory.getOtherUserDetails(uuid)  ;  
    } catch (e) {
      rethrow;
    }
    
  }

}