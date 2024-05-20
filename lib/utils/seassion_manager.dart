import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SeassionManager {
   static Future<void> setBoolData(String key, bool object) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, object);
  }

   static Future getBoolData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final booldata = prefs.getBool(key);
    if (booldata != null) {
      return booldata;
    }
    return null;
  }

  static Future<void> setStringData(String key, String object) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, object);
  }

   static Future getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final stringdata = prefs.getString(key);
    if (stringdata != null) {
      return stringdata;
    }
    return null;
  }

  static Future<void> saveObjectToSharedPreferences(
      String key, Map<String, dynamic> object) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringData = jsonEncode(object);
    await prefs.setString(key, jsonStringData);
  }

  static Future<Map<String, dynamic>?> getObjectFromSharedPreferences(
      String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static removeObjectFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    return true;
  }
}
