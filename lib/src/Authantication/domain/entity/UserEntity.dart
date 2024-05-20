

import 'package:equatable/equatable.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';


class UserEntity extends Equatable {

  String? uuid;
  String? uniqueName ;
  String? userName ;
  String? password ;
  String? email ;
  String? profileImage ;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;
  String? birthdate;
  String? token;
  bool? isOnline ;
  List<FollowEntity>? followers;
  List<FollowEntity>? following;

  UserEntity({
    this.uuid,
    this.uniqueName,
    this.userName,
    this.profileImage,
    this.password,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.birthdate,
    this.followers,
    this.following,
    this.isOnline,
    this.token,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props =>[
    uuid,
    uuid,
    uuid,
    uniqueName,
    uniqueName,
    userName,
    profileImage,
    password,
    email,
    phoneNumber,
    createdAt,
    updatedAt,
    birthdate,
    followers,
    following,
    isOnline,
    token,
  ];

}






