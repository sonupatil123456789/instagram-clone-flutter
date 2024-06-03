import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';

abstract interface class RemoteDataSource {
  Future<UserModel> creatAcountWithEmailIdPassword(UserModel userModel);

  Future<UserModel> logInWithEmailIdPassword(UserModel userModel);

  void resetPassword(String email);

  Future<List<UserModel>> getAllUserList();

  Future<UserModel> getUser(bool isRefresh) ;

  Stream<List<UserModel>> getAllUserStreamList(String searchQuery);

  void isUserOnline(bool isOnline);

  Future<bool> signeOutUser();
  
  Future<bool> updateUserInformation(UserModel updatedUserInfo);


}
