import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseStatusCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseUserCollection.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/UserStatusModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'auth_remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  FirebaseUserCollection userCollection;
  UserModel userModel;
  FirebaseStatusCollection statusCollection;

  RemoteDataSourceImpl(
    this.userCollection,
    this.userModel,
    this.statusCollection,

  );

  FirebaseAuth get auth => userCollection.firebaseAuthInstance;
  UserCredential? _credential;
  bool isFetched = false;

  @override
  Future<UserModel> creatAcountWithEmailIdPassword(UserModel user) async {
    try {
      _credential = await auth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);

      final token = await _credential!.user!.getIdToken();

      userModel = userModel.copyWith(
          uuid: _credential!.user!.uid.toString(),
          email: user.email,
          userName: user.userName,
          password: user.password,
          phoneNumber: user.phoneNumber,
          followers: [],
          following: [],
          uniqueName: user.uniqueName,
          createdAt: _credential!.user!.metadata.creationTime.toString(),
          updatedAt: _credential!.user!.metadata.lastSignInTime.toString(),
          isOnline: true,
          token: token);

      // CoustomLog.coustomLogData("creatAcountWithEmailIdPassword", userModel);

      await userCollection.setUserDocument( _credential!.user!.uid.toString(), userModel.toMap());

      CoustomLog.coustomLogData("creatAcountWithEmailIdPassword", userModel.toMap().toString());

      return UserModel.fromMap(userModel.toMap());
    } catch (error, stack) {
      CoustomLog.coustomLogError("creatAcountWithEmailIdPassword", error, stack);
      rethrow;
    }
  }

  @override
  Future<UserModel> logInWithEmailIdPassword(UserModel user) async {
    try {
      _credential = await auth.signInWithEmailAndPassword(email: user.email!, password: user.password!);

      await userCollection
          .updateUserDocument(_credential!.user!.uid.toString(), {
        "password": user.password!,
        "updatedAt": _credential!.user!.metadata.lastSignInTime.toString()
      });

      DocumentSnapshot docSnapshot = await userCollection.getUserDocument(_credential!.user!.uid.toString());
      final value = docSnapshot.data() as Map<String, dynamic>;
      userModel = UserModel.fromMap(value);

      
      await FirebaseStatusCollection().setStatusDocument( userModel.uuid!,UserStatusModel(
        uuid: userModel.uuid,
        uniqueName: userModel.uniqueName,
        profileImage: userModel.profileImage,
        statusList: []
      ).toMap());

    CoustomLog.coustomLogData("logInWithEmailIdPassword", userModel);

    return userModel;
    } catch (error, stack) {
      CoustomLog.coustomLogError("LogInWithEmailIdPassword", error, stack);
      rethrow;
    }
  }

  @override
  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (error, stack) {
      CoustomLog.coustomLogError("resetPassword", error, stack);
      rethrow;
    }
  }

  @override
  void isUserOnline(bool isOnline) async {
    try {
      await userCollection.updateUserDocument(
          auth.currentUser!.uid.toString(), {"isOnline": isOnline});
      CoustomLog.coustomLogData("isUserOnline", isOnline);
    } catch (error, stack) {
      CoustomLog.coustomLogError("isUserOnline", error, stack);
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAllUserList() async {
    try {
      QuerySnapshot userList = await userCollection.getAllUserDocument();
      final value = userList.docs
          .map((userList) =>
              UserModel.fromMap(userList.data() as Map<String, dynamic>))
          .toList();
      CoustomLog.coustomLogData("getAllUserList", value);
      return value;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllUserList", error, stack);
      rethrow;
    }
  }

  @override
  Stream<List<UserModel>> getAllUserStreamList(String searchQuery) {
    final userId = auth.currentUser!.uid;
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> userList =
          userCollection.getAllUserDocumentRealTime(searchQuery, userId);
      Stream<List<UserModel>> mappedStream = userList.map((event) =>
      event.docs.map((e) => UserModel.fromMap(e.data())).toList());
      CoustomLog.coustomLogData("getAllUserStreamList", mappedStream);
      return mappedStream;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getAllUserStreamList", error, stack);
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser(bool isRefresh) async {
    try {
      if (!isFetched || isRefresh) {
        DocumentSnapshot value = await userCollection.getUserDocument(auth.currentUser!.uid.toString(),
      );
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      isFetched = true;
      // CoustomLog.coustomLogData("getUser", userModel);
      print("Requesting user Data from firebase database ");
      return userModel;
      }
       print("Requesting user Data from already present cashed ");
      // CoustomLog.coustomLogData("getUser", userModel);
      return userModel;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getUser", error, stack);
      rethrow;
    }
  }
}
