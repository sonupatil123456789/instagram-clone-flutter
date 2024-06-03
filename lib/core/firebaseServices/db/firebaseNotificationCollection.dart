
import '../firebaseServices.dart';

class FirebaseNotificationCollection extends FirebaseServiceProvider {


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
