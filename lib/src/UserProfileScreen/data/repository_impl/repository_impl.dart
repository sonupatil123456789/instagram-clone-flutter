
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/UserProfileScreen/data/data_sources/remote_data_source.dart';
import '../../domain/repository/repository.dart';


class UserProfileScreenRepositoryImpl implements UserProfileScreenRepository {
  UserProfileScreenRemoteDataSource userProfileScreenRemoteDataSource;

  UserProfileScreenRepositoryImpl(this.userProfileScreenRemoteDataSource);
  
  @override
  Future<List<PostEntity>> getMyPostPost(isRefresh) async {
    return await userProfileScreenRemoteDataSource.getMyPostPost(isRefresh);
  
  }

 
}
