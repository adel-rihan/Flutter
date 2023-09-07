import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> checkKey(String key) async {
    return prefs!.containsKey(key);
  }

  static Future<bool> setString(String key, String value) async {
    return await prefs!.setString(key, value);
  }

  static Future<String> getString(String key) async {
    return prefs!.getString(key)!;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await prefs!.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    return prefs!.getBool(key)!;
  }

  static Future<bool> setInt(String key, int value) async {
    return await prefs!.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    return prefs!.getInt(key)!;
  }
}
