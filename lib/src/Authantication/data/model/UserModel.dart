
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';

class UserModel extends UserEntity   {
// class UserModel extends UserEntity implements Equatable  {
  UserModel({
    super.uuid,
    super.uniqueName,
    super.userName,
    super.password,
    super.email,
    super.phoneNumber,
    super.createdAt,
    super.updatedAt,
    super.birthdate,
    super.isOnline,
    super.profileImage,
    super.token,
    super.followers,
    super.following,
  });

  UserModel copyWith({
    String? uuid,
    String? uniqueName,
    String? userName,
    String? password,
    String? email,
    String? phoneNumber,
    String? profileImage,
    String? createdAt,
    String? updatedAt,
    String? birthdate,
    bool? isOnline,
    String? token,
    List<FollowModel>? followers,
    List<FollowModel>? following,
  }) {
    return UserModel(
        uuid: uuid ?? this.uuid,
        uniqueName: uniqueName ?? this.uniqueName,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        birthdate: birthdate ?? this.birthdate,
        isOnline: isOnline ?? this.isOnline,
        token: token ?? this.token,
        profileImage: profileImage ?? this.profileImage,
        followers: followers ?? this.followers,
        following: following ?? this.following);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uuid: entity.uuid,
      uniqueName: entity.uniqueName,
      userName: entity.userName,
      password: entity.password,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      birthdate: entity.birthdate,
      isOnline: entity.isOnline,
      token: entity.token,
      profileImage: entity.profileImage,
      following: entity.following,
      followers: entity.followers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'uniqueName': uniqueName,
      'userName': userName,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'birthdate': birthdate,
      'isOnline': isOnline,
      'token': token,
      'profileImage': profileImage,
      'following': following != null ? following?.map((e) => FollowModel(
              uuid: e.uuid,
              uniqueName: e.uniqueName,
              profileImage: e.profileImage).toMap()).toList() : [],
      'followers':followers != null ? followers?.map((e) => FollowModel(
              uuid: e.uuid,
              uniqueName: e.uniqueName,
              profileImage: e.profileImage)
          .toMap()).toList() : [],
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      uniqueName:
          map['uniqueName'] != null ? map['uniqueName'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      token: map['token'] != null ? map['token'] as String : null,
      followers: (map['followers'] as List<dynamic>?)
          ?.map((e) => FollowModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      following: (map['following'] as List<dynamic>?)
          ?.map((e) => FollowModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'UserModel ('
        'uuid: $uuid, '
        'uniqueName: $uniqueName, '
        'userName: $userName, '
        'password: $password, '
        'email: $email, '
        'profileImage: $profileImage, '
        'phoneNumber: $phoneNumber, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'birthdate: $birthdate, '
        'isOnline: $isOnline, '
        'following: $following, '
        'followers: $followers, '
        'isOnline: $isOnline, '
        'token: $token )';
  }

}
