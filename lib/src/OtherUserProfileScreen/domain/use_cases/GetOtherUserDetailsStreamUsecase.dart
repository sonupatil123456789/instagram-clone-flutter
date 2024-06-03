
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/repository/repository.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

class GetOtherUserDetailsStreamUsecase implements StreamedUseCase<Stream<UserEntity> , String>{
  OtherUserRepository reposatory;

  GetOtherUserDetailsStreamUsecase(this.reposatory);
  @override
  Stream<UserEntity>  call(String uuid, BuildContext context) {

    try {
      return reposatory.getOtherUserDetailsStream(uuid);      
    } catch (e) {
      rethrow;
    }
    
  }

}