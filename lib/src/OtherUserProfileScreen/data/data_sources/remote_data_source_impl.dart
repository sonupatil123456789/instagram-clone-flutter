
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebasePostCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseUserCollection.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';

import 'remote_data_source.dart';

class OtherUserRemoteDataSourceImpl implements OtherUserRemoteDataSource {
  FirebasePostCollection postCollection;
  PostModel postModel;
  FirebaseUserCollection userCollection ;
  UserModel userData;

  OtherUserRemoteDataSourceImpl(
    this.postCollection,
    this.postModel,
    this.userCollection,
    this.userData,
  );

  late QuerySnapshot? querySnapshot;
  List<PostModel> othersPosts = [];

  FirebaseAuth get auth => postCollection.firebaseAuthInstance;
  
  @override
  Stream<UserModel> getOtherUserDetailsStream(String uuid) {

    try {
      Stream<DocumentSnapshot> value =  userCollection.getUserDocumentStream(auth.currentUser!.uid.toString(),);
      Stream<UserModel> getOtherUserDetails =  value.map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
      CoustomLog.coustomLogData("getOtherUserDetailsStream", getOtherUserDetails);
      return getOtherUserDetails;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getOtherUserDetailsStream", error, stack);
      rethrow;
    }
    
  }
  
  @override
  Future<List<PostModel>> getOtherUserPost(String uuid ) async {

    try {

        othersPosts.clear();
          querySnapshot = await postCollection.getUserSpecificPosts(uuid);

          querySnapshot?.docs.forEach((element) {
            othersPosts.add(PostModel.fromMap(element.data() as Map<String, dynamic>));
          });

        CoustomLog.coustomLogData("getOtherUserPost", othersPosts.length.toString());
        return  othersPosts;

    } catch (error, stack) {
      CoustomLog.coustomLogError("getOtherUserPost", error, stack);
      rethrow;
    }
  }
  
  
  @override
  Future<UserModel> getOtherUserDetails(String uuid)async {
     try {
      DocumentSnapshot value = await userCollection.getUserDocument(uuid);
      UserModel getOtherUserDetails =  UserModel.fromMap(value.data() as Map<String, dynamic>);
      CoustomLog.coustomLogData("getOtherUserDetails", getOtherUserDetails);
      return getOtherUserDetails;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getOtherUserDetails", error, stack);
      rethrow;
    }
  }


}
