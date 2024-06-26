
import 'package:cloud_firestore/cloud_firestore.dart';


import '../firebaseServices.dart';

class FirebaseChatCollection extends FirebaseServiceProvider {

  // FirebaseAuth get auth => super.firebaseAuthInstance;

  // path id is user path id or uuid of that user that i am getting from local storage 



  databasePath() {
    return dataBase.collection('Chat');
  }


  Future setMessageDocument(String senderId ,String reciverId , String messageId , Map<String,dynamic> message) async {
    return await dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).collection("Messages").doc(messageId).set(message);
  }

  Future setLastMessageDocument(String senderId ,String reciverId , Map<String,dynamic> lastMessage) async {
    return await dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).set(lastMessage);
  }

  Future<DocumentSnapshot>getLastMessageDocument(String senderId ,String reciverId ) async {
    return await dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).get();
  }
  updateLastMessageDocument(String senderId ,String reciverId ,Map<String,dynamic> data ) async {
    return await dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).update(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserConversationListStream(String senderId ,String reciverId) {
      return  dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).collection("Messages").orderBy("createdAt",descending: true).snapshots();
  }

  Future updateMessageDocument(String senderId ,String reciverId , String messageId , Map<String,dynamic> message) async {
    return await dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).collection("Messages").doc(messageId).update(message);
  }

  Future deletMessageDocument(String senderId ,String reciverId , String messageId ) async {
    return await dataBase.collection('Chat').doc(senderId).collection("ChatInfo").doc(reciverId).collection("Messages").doc(messageId).delete();
  }



  // Future updatePostDocument(pathid, post) async {
  //   return await databasePath().doc(pathid).update(post);
  // }

  // Future getPostrDocument(pathid) async {
  //   return await databasePath().doc(pathid).get();
  // }

  // Future getAllPostDocument() async {
  //   return await databasePath().get();
  // }

  // Future<QuerySnapshot<Map<String,dynamic>>> getUserSpecificPosts(String uuid) async {
  //   return await dataBase.collection('Post').where('uuid', isEqualTo: uuid).get();
  // }

  //  Future getPerticulatFilePost(String postImageFileType) async {
  //   return dataBase.collection('Post').where('postImageFileType', isEqualTo:postImageFileType).get();
  // }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getUserSpecificPostsStream(List<String> followingUserUuidList ) {
  //   if (followingUserUuidList.isNotEmpty) {
  //     return dataBase.collection('Post').where('uuid', whereIn: followingUserUuidList).snapshots();
  //   } 
  //   return  dataBase.collection('Post').snapshots(); 
  // }
  
  // Stream<QuerySnapshot<Map<String, dynamic>>> getAllPostDocumentStream()  {
  //     return dataBase.collection('Post').snapshots();
  // }

  // Future updatePostArrey(String pathid, String field ,Map<String,dynamic> data) async {
  //   return await databasePath().doc(pathid).update({
  //     field: FieldValue.arrayUnion([data])
  //   });
  // }

  // Future removePostArrey(String pathid, String field ,Map<String,dynamic> data) async {
  //   return await databasePath().doc(pathid).update({
  //     field: FieldValue.arrayRemove([data])
  //   });
  // }

  // Future queryPostArrey(String field , String uuid,Map<String,dynamic> data) async {
  //   return await dataBase.collection('Post').where('postId', isEqualTo: uuid).where(field , arrayContains: data ).get();
  // }

  // Future setCommentDocument(String postId ,String commentId ,Map<String,dynamic> comment) async {
  //   return await dataBase.collection('Post').doc(postId).collection("Comments").doc(commentId).set(comment);
  // }

  // Future deletCommentDocument(String postId ,String commentId ) async {
  //   return await dataBase.collection('Post').doc(postId).collection("Comments").doc(commentId).delete();
  // }

  //  Stream<QuerySnapshot<Map<String, dynamic>>> getUserPostCommentsStream(String postId) {
  //     return  dataBase.collection('Post').doc(postId).collection("Comments").snapshots();
  // }



  // Future setUserAddressSubCollectionDocument(pathid, address) async {
  //   return await addressSubDatabasePath(pathid).doc().set(address);
  // }

  //   Future getAllReplayToCommentDocument(String postId ,String commentId ,  ) async {
  //   return await dataBase.collection('Post').doc(postId).collection("Comments").doc(commentId).collection("ReplayComments").where("replyedTo.commentId", isEqualTo: commentId).get();
  // }

  // Future  queryUserDocument( querryField , queryData) async {
  //   return await databasePath().where(querryField, isEqualTo: queryData).get();
  // }
}
