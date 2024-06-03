import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'package:path/path.dart' as path;
import '../firebaseServices.dart';

class StorageBucket extends FirebaseServiceProvider {

  

  Future<String> uploadPostFile(String file,fileType,uuid) async {
    String fileName = path.basename(file);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String uploadFileName = "Instagram_${fileType}_${timestamp}_$fileName";
    CoustomLog.coustomLogData("uploadFileName", uploadFileName);
    Reference reference = storageBucket.ref().child("Files/$uuid/Post/$fileType/$uploadFileName");
    await reference.putFile(File(file.toString()));
    final String downloadURL = "${await reference.getDownloadURL()}";
    CoustomLog.coustomLogData("downloadURL", downloadURL);
    return downloadURL; 
  }

  Future<String> uploadProfilepicFile(String file,uuid) async {
      String fileName = path.basename(file);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String uploadFileName = "Instagram_${timestamp}_$fileName";
    CoustomLog.coustomLogData("uploadFileName", uploadFileName);
    Reference reference = storageBucket.ref().child("Files/$uuid/Profilepic/");
    await reference.putFile(File(file.toString()));
    final String downloadURL = "${await reference.getDownloadURL()}_$uploadFileName";
    CoustomLog.coustomLogData("downloadURL", downloadURL);
    return downloadURL; 
  }


  Future<String> uploadStatusFile(String file,fileType,uuid) async {
      String fileName = path.basename(file);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String uploadFileName = "Instagram_${fileType}_${timestamp}_$fileName";
    CoustomLog.coustomLogData("uploadFileName", uploadFileName);
    Reference reference = storageBucket.ref().child("Files/$uuid/Status/$fileType/$uploadFileName");
    await reference.putFile(File(file.toString()));
    final String downloadURL = "${await reference.getDownloadURL()}";
    CoustomLog.coustomLogData("downloadURL", downloadURL);
    return downloadURL; 

  }
 


    Future<String> uploadChatFile(String file,fileType,uuid) async {
    String fileName = path.basename(file);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String uploadFileName = "Instagram_${fileType}_${timestamp}_$fileName";
    CoustomLog.coustomLogData("uploadFileName", uploadFileName);
    Reference reference = storageBucket.ref().child("Files/$uuid/Chat/$fileType/$uploadFileName");
    await reference.putFile(File(file.toString()));
    final String downloadURL = "${await reference.getDownloadURL()}";
    CoustomLog.coustomLogData("downloadURL", downloadURL);
    return downloadURL; 
  }

}
