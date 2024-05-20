import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebasePostCollection.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';

import 'remote_data_source.dart';

class ReelScreenRemoteDataSourceImpl implements ReelScreenRemoteDataSource {
  FirebasePostCollection postCollection;
  PostModel postModel;

  ReelScreenRemoteDataSourceImpl(
    this.postCollection,
    this.postModel,
  );

  late QuerySnapshot? querySnapshot;
  List<PostModel> posts = [];
  bool isFetched = false;

  FirebaseAuth get auth => postCollection.firebaseAuthInstance;


  
  @override
  Future<List<PostModel>> getAllVideoPost(isRefresh) async {
      final video = CustomUploadFileType.Video.enumToString();
      try {
      if (!isFetched || isRefresh) {
        posts.clear();
        QuerySnapshot querysnapshot = await postCollection.getPerticulatFilePost(video);
        for (var element in querysnapshot.docs) {
          posts.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
        }
        CoustomLog.coustomLogData("getAllVideoPost", posts);
        isFetched = true;
        return posts;
      } else {
        return posts;
      }
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllVideoPost", error, stack);
      rethrow;
    }
  }
}




