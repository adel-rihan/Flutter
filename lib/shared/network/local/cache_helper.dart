import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> check(String key) async {
    return prefs.containsKey(key);
  }

  static Future<bool> set(String key, dynamic value) async {
    if (value is bool) return await prefs.setBool(key, value);
    if (value is int) return await prefs.setInt(key, value);
    if (value is double) return await prefs.setDouble(key, value);

    return await prefs.setString(key, value);
  }

  static Future<dynamic> get(String key) async {
    return prefs.get(key);
  }
}
