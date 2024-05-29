import 'package:shared_preferences/shared_preferences.dart';

class DBHelper {
  static late SharedPreferences preferences;

  Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
