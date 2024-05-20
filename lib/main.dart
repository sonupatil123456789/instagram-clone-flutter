import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram_clone/Application.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveFollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserModelAdapter());
  Hive.registerAdapter(HiveFollowModelAdapter());
  await Hive.openBox<HiveUserModel>('UserDataBase');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, );
  runApp(const Application());    
}
