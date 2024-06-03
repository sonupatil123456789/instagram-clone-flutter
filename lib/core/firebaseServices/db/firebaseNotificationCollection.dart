import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebaseServices.dart';

class FirebaseNotificationCollection extends FirebaseServiceProvider {
  @override
  FirebaseFirestore get dataBase => super.dataBase;


  databasePath() {
    return dataBase.collection('Notification');
  }


  Future setNotificationDocument(String notificationId ,notification) async {
    return await databasePath().doc(notificationId).set(notification);
  }

  Future updateNotificationDocument(notificationId, notification) async {
    return await databasePath().doc(notificationId).update(notification);
  }

  Future deletNotificationDocument(notificationId) async {
    return await databasePath().doc(notificationId).delete();
  }

  



}
