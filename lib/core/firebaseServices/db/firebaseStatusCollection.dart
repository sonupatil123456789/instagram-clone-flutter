
import 'package:cloud_firestore/cloud_firestore.dart';


import '../firebaseServices.dart';

class FirebaseStatusCollection extends FirebaseServiceProvider {
  @override
  FirebaseFirestore get dataBase => super.dataBase;

  // FirebaseAuth get auth => super.firebaseAuthInstance;

  // path id is user path id or uuid of that user that i am getting from local storage 



  databasePath() {
    return dataBase.collection('Status');
  }

  // addressSubDatabasePath(pathid) {
  //   return databasePath().doc(pathid).collection('Address');
  // }

  Future setStatusDocument(String userId ,Map<String,dynamic> status) async {
    return await databasePath().doc(userId).set(status);
  }

  Future setStatus(String userId , String userStatusId, status) async {
    return await databasePath().doc(userId).collection("UserStatus").doc(userStatusId).set(status);
  }

  Future<DocumentSnapshot> getStatusDocument(String userId) async {
    return await dataBase.collection('Status').doc(userId).get();
  }

  Future updateStatusDocument(userStatusId, status) async {
    return await databasePath().doc(userStatusId).update(status);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStatusDocument(List<String> followersUserUuidList )  {
      return dataBase.collection('Status').where('uuid', whereIn: followersUserUuidList).snapshots();
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getAllFollowersStatusDocumentStream(List <String>followersUserUuidList)async {
  //     return dataBase.collection('Status').where('uuid', whereIn: followersUserUuidList).orderBy("uuid" , descending: false).get();
  // }

   Future<QuerySnapshot> getStatus(List <String>followersUserUuidList) async {
    return await dataBase.collection('Status').where("uuid" ,whereIn:followersUserUuidList ).get();
  }






  Future updateStatusArrey(String statusId, String field ,Map<String,dynamic> data) async {
    return await dataBase.collection('Status').doc(statusId).update({
      field: FieldValue.arrayUnion([data])
    });
  }



  Future removeStatusArrey(String pathid, String field ,Map<String,dynamic> data) async {
    return await databasePath().doc(pathid).update({
      field: FieldValue.arrayRemove([data])
    });
  }



  

}
