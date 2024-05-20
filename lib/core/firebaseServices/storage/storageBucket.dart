import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import '../firebaseServices.dart';

class StorageBucket extends FirebaseServiceProvider {
  @override
  // TODO: implement storageBucket
  FirebaseStorage get storageBucket => super.storageBucket;

  

  Future<String> uploadImage(String file,fileType,uuid) async {
    String fileName = path.basename(file);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    String uploadFileName = "Instagram_${fileName}_${fileType}_$timestamp";




    Reference reference = await storageBucket.ref().child("Files/$uuid/$fileType/$uploadFileName");
    await reference.putFile(File(file.toString()));
    final String downloadURL = await reference.getDownloadURL();

    return downloadURL;

    // Map<String, dynamic> data = {
    //   "url": file.name.toString(),
    //   "fileName": fileName,
    //   "updatedAt": date.toString()
    // };
  }
}
