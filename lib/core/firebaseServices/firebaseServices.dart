import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServiceProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuthInstance => _auth;

  final FirebaseFirestore _dataBase = FirebaseFirestore.instance;
  FirebaseFirestore get dataBase => _dataBase;

   final FirebaseStorage _storage =   FirebaseStorage.instance;
  FirebaseStorage get storageBucket =>_storage;


}
