import 'package:instagram_clone/src/Authantication/data/data_sources/auth_local_data_source.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/auth_repository/auth_repository.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  RemoteDataSource remoteDataSource;
  LocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<UserEntity> logInWithEmailIdPassword(UserEntity user) async {
    try {
      final data = await remoteDataSource
          .logInWithEmailIdPassword(UserModel.fromEntity(user));
      await localDataSource.saveUserDataToHiveDatabase(data);
      return data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> creatAcountWithEmailIdPassword(UserEntity user) async {
    try {
      final data = await remoteDataSource
          .creatAcountWithEmailIdPassword(UserModel.fromEntity(user));
      await localDataSource.saveUserDataToHiveDatabase(data);
      return data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  void resetPassword(String email) {
    remoteDataSource.resetPassword(email);
  }

  @override
  void isUserOnline(bool isOnline) {
    remoteDataSource.isUserOnline(isOnline);
  }

  @override
  Future<List<UserEntity>> getAllUserList() {
    return remoteDataSource.getAllUserList();
  }

  @override
  Stream<List<UserEntity>> getAllUserStreamList(String searchQuery) {
    return remoteDataSource.getAllUserStreamList(searchQuery);
  }

  @override
  Future<UserEntity> getUser(bool isRefresh) async {
    try {
      final data = await remoteDataSource.getUser(isRefresh);
      await localDataSource.saveUserDataToHiveDatabase(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> signeOutUser() async {
    try {
      final isSigneOut = await remoteDataSource.signeOutUser();
      if (isSigneOut == true) {
        await localDataSource.deletDataFromHiveDatabase('User');
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateUserInformation(UserEntity updatedUserInfo) async {
    return await remoteDataSource
        .updateUserInformation(UserModel.fromEntity(updatedUserInfo));
  }
}
