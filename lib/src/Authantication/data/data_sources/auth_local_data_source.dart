


import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';

abstract interface class LocalDataSource{

  Future saveUserDataToHiveDatabase(UserEntity entity) ;
  Future getUserDataFromHiveDatabase(String key) ;
  
}
