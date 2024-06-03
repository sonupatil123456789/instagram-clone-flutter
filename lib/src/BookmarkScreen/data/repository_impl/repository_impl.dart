
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/BookmarkScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/repository/repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRemoteDataSource bookmarkRemoteDataSource;

  BookmarkRepositoryImpl(this.bookmarkRemoteDataSource);

  @override
  Future<bool> deletBookmark(String bookmarkId)async  {
    return await bookmarkRemoteDataSource.deletBookmark(bookmarkId);
  }

  @override
  Future<List<PostModel>> getMyBookmarks(bool isRefresh) async{
  return await bookmarkRemoteDataSource.getMyBookmarks(isRefresh);
  }

  @override
  Future<bool> postBookmark(PostEntity bookmark) async{
    return await bookmarkRemoteDataSource.postBookmark(PostModel.fromEntity(bookmark));
  }

  
  
}
