


import 'package:hive/hive.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'HiveFollowModel.dart';

part 'HiveUserModel.g.dart';

@HiveType(typeId: 0)
class HiveUserModel  {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  String? uniqueName ;
  @HiveField(2)
  String? userName ;
  @HiveField(3)
  String? password ;
   @HiveField(4)
  String? email ;
   @HiveField(5)
  String? profileImage ;
   @HiveField(6)
  String? phoneNumber;
   @HiveField(7)
  String? createdAt;
   @HiveField(8)
  String? updatedAt;
   @HiveField(9)
  String? birthdate;
   @HiveField(10)
  String? token;
  @HiveField(11)
  List<HiveFollowModel>? following;
  @HiveField(12)
  List<HiveFollowModel>? followers;


  HiveUserModel({
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
    this.following,
    this.followers,
    this.token,
  });


  factory HiveUserModel.fromEntity(UserEntity entity){
    return HiveUserModel(
        uuid: entity.uuid,
      uniqueName: entity.uniqueName,
      userName: entity.userName,
      password: entity.password,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      birthdate: entity.birthdate,
      token: entity.token,
      profileImage: entity.profileImage,
      following: entity.following?.map((e) => HiveFollowModel.fromEntity(e)).toList(),
      followers: entity.followers?.map((e) => HiveFollowModel.fromEntity(e)).toList(),
    );
  }
  static UserModel toEntity(HiveUserModel? hiveModel){
    return UserModel(
        uuid : hiveModel?.uuid,
      uniqueName: hiveModel?.uniqueName,
      userName: hiveModel?.userName,
      password: hiveModel?.password,
      email: hiveModel?.email,
      phoneNumber: hiveModel?.phoneNumber,
      createdAt: hiveModel?.createdAt,
      updatedAt: hiveModel?.updatedAt,
      birthdate: hiveModel?.birthdate,
      token: hiveModel?.token,
      profileImage: hiveModel?.profileImage,
      following: hiveModel?.following?.map((e) => HiveFollowModel.toEntity(e)).toList(),
      followers: hiveModel?.followers?.map((e) => HiveFollowModel.toEntity(e)).toList(),
    );
  }
  


}






