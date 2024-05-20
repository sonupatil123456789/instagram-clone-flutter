
import 'package:cloud_firestore/cloud_firestore.dart';


import '../firebaseServices.dart';

class FirebaseUserCollection extends FirebaseServiceProvider {
  @override
  FirebaseFirestore get dataBase => super.dataBase;

  // FirebaseAuth get auth => super.firebaseAuthInstance;

  // path id is user path id or uuid of that user that i am getting from local storage 



  databasePath() {
    return dataBase.collection('Users');
  }

  Future setUserDocument(pathid, user) async {
    return await databasePath().doc(pathid).set(user);
  }

  Future getAllUserDocument() async {
    return await databasePath().get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserDocumentRealTime(String searchQuery, String uuid ) {
    if (searchQuery.isEmpty) {
      return dataBase.collection('Users').where("uuid" , isNotEqualTo:uuid ).snapshots();
    } else {
      return dataBase.collection('Users').where("uuid" , isNotEqualTo:uuid ).where("uniqueName", isEqualTo: searchQuery).snapshots();
    }
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllFriendsRealTime(List<String> following) {
      return dataBase.collection('Users').where("uuid" , whereIn:following ).snapshots();
  }


  Future updateUserDocument(pathid, user) async {
    return await databasePath().doc(pathid).update(user);
  }

  Future updateUserArrey(String pathid, String field ,Map<String,dynamic> data) async {
    return await databasePath().doc(pathid).update({
      field: FieldValue.arrayUnion([data])
    });
  }

  Future removeUserArrey(String pathid, String field ,Map<String,dynamic> data) async {
    return await databasePath().doc(pathid).update({
      field: FieldValue.arrayRemove([data])
    });
  }

  Future queryUserArrey(String field , String uuid,Map<String,dynamic> data) async {
    return await dataBase.collection('Users').where('uuid', isEqualTo: uuid).where(field , arrayContains: data ).get();
  }

  Future<DocumentSnapshot> getUserDocument(pathid) async {
    return await databasePath().doc(pathid).get();
  }
  

  // followUserSubDatabasePath(pathid) {
  //   return databasePath().doc(pathid).collection('followers');
  // }

  // Future setUserAddressSubCollectionDocument(pathid, address) async {
  //   return await addressSubDatabasePath(pathid).doc().set(address);
  // }

 
}
