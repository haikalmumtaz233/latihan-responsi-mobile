import 'shared_preferences.dart';

class SaveToLocalDb {
  static Future<bool> clear() {
    return DBHelper.preferences.clear();
  }

  static bool containsKey(String key) {
    return DBHelper.preferences.containsKey(key);
  }

  static dynamic get(String key) {
    return DBHelper.preferences.get(key);
  }

  static dynamic delete(String key) {
    return DBHelper.preferences.remove(key);
  }

  static bool? getBool(String key) {
    return DBHelper.preferences.getBool(key);
  }

  static double? getDouble(String key) {
    return DBHelper.preferences.getDouble(key);
  }

  static int? getInt(String key) {
    return DBHelper.preferences.getInt(key);
  }

  static Set<String> getKeys() {
    return DBHelper.preferences.getKeys();
  }

  static String? getString(String key) {
    return DBHelper.preferences.getString(key);
  }

  static List<String>? getStringList(String key) {
    return DBHelper.preferences.getStringList(key);
  }

  static Future<void> reload() {
    return DBHelper.preferences.reload();
  }

  static Future<bool> remove(String key) {
    return DBHelper.preferences.remove(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return DBHelper.preferences.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) {
    return DBHelper.preferences.setDouble(key, value);
  }

  static Future<bool> setInt(String key, int value) {
    return DBHelper.preferences.setInt(key, value);
  }

  static Future<bool> setString(String key, String value) {
    return DBHelper.preferences.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return DBHelper.preferences.setStringList(key, value);
  }

  ///Singleton factory
  static final SaveToLocalDb _instance = SaveToLocalDb._internal();

  factory SaveToLocalDb() {
    return _instance;
  }

  SaveToLocalDb._internal();
}
