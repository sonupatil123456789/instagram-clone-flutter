import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebaseServices.dart';

class FirebaseBookmarkCollection extends FirebaseServiceProvider {


  databasePath() {
    return dataBase.collection('Bookmark');
  }

  Future setBookmarkDocument(String bookmarkId ,bookmark) async {
    return await databasePath().doc(bookmarkId).set(bookmark);
  }

  Future setALlUserBookmarkDocument(String uuid,bookmarkId ,Map<String,dynamic>bookmark) async {
    return await dataBase.collection('Bookmark').doc(uuid).collection("BookmarkList").doc(bookmarkId).set(bookmark);
  }
  Future<QuerySnapshot> getALlUserBookmarkDocument(String uuid) async {
    return await dataBase.collection('Bookmark').doc(uuid).collection("BookmarkList").get();
  }

   Future deletBookmarkDocument(String uuid,String bookmarkId) async {
   return await dataBase.collection('Bookmark').doc(uuid).collection("BookmarkList").doc(bookmarkId).delete();
  }

  


}
