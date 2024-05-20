import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseUserCollection.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/DiscoverScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  FirebaseUserCollection userCollection;
  UserModel? userModel;
  // StorageBucket storage;

  DiscoverRemoteDataSourceImpl(
    this.userCollection,
    this.userModel,
    // this.storage,
  );

  FirebaseAuth get auth => userCollection.firebaseAuthInstance;

  @override
  Future<FollowModel> followUser(FollowModel following) async {
    try {

      FollowModel follower = FollowModel(
          uuid: userModel!.uuid,
          uniqueName: userModel!.uniqueName,
          profileImage: userModel!.profileImage);

      QuerySnapshot querySnapshot = await userCollection.queryUserArrey("following",userModel!.uuid.toString() ,following.toMap() );

      if (querySnapshot.docs.isNotEmpty) {
        await userCollection.removeUserArrey(userModel!.uuid.toString(),"following", following.toMap());
        await userCollection.removeUserArrey(following.uuid.toString(),"followers", follower.toMap());
      } else {
        await userCollection.updateUserArrey(userModel!.uuid.toString(),"following", following.toMap());
        await userCollection.updateUserArrey(following.uuid.toString(),"followers", follower.toMap());
      }

      return follower;
      } catch (error, stack) {
      CoustomLog.coustomLogError("followUser", error, stack);
      rethrow;
    }
  }
}


