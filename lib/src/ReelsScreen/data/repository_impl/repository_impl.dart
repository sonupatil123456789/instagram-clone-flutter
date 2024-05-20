
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/ReelsScreen/domain/repository/repository.dart';

import '../data_sources/remote_data_source.dart';

class ReelScreenRepositoryImpl implements ReelScreenRepository {
  ReelScreenRemoteDataSource reelScreenRemoteDataSource;

  ReelScreenRepositoryImpl(this.reelScreenRemoteDataSource);

  @override
  Future<List<PostEntity>> getAllVideoPost(isRefresh) async {
   return reelScreenRemoteDataSource.getAllVideoPost(isRefresh);
  }


}
