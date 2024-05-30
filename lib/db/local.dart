import 'package:shared_preferences/shared_preferences.dart';

class SaveToLocalDb {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    if (_prefs == null) await init();
    return _prefs!.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    if (_prefs == null) await init();
    return _prefs!.getString(key);
  }

  static Future<bool> remove(String key) async {
    if (_prefs == null) await init();
    return _prefs!.remove(key);
  }
}
