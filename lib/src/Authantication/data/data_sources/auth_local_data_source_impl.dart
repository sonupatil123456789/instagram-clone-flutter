


import 'package:hive/hive.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'auth_local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource{
  Box<HiveUserModel>  userBox;
  LocalDataSourceImpl(this.userBox);
  
  @override
  Future saveUserDataToHiveDatabase(UserEntity entity) async {
   try {
      HiveUserModel storage =  HiveUserModel.fromEntity(entity);
      await userBox.put("User", storage);
    } catch (error, stack) {
      CoustomLog.coustomLogError("saveUserDataToHiveDatabase", error, stack);
      rethrow;
    }
  }
  
  @override
  Future<UserModel> getUserDataFromHiveDatabase(String key)async  {
    HiveUserModel? getStorage  = await userBox.get(key);
    UserModel data = HiveUserModel.toEntity(getStorage);
    return data;
  }
  
}