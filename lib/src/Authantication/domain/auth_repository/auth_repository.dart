import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';

abstract interface class AuthRepository {
  Future<UserEntity> creatAcountWithEmailIdPassword(UserEntity user);

  Future<UserEntity> logInWithEmailIdPassword(UserEntity user);

  Future<List<UserEntity>> getAllUserList();

  Future<UserEntity> getUser(bool isRefresh );

  Stream<List<UserEntity>> getAllUserStreamList(String searchQuery);

  void resetPassword(String email);

  void isUserOnline(bool isOnline);

  Future<bool> signeOutUser();
  
  Future<bool> updateUserInformation(UserEntity updatedUserInfo);
}
