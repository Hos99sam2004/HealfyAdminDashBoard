import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  late SharedPreferences _instance;

  Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  setBool(String key, bool value) {
    _instance.setBool(key, value);
  }

  bool getBool(String key) {
    return _instance.getBool(key) ?? false;
  }

  setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  getString(String key) {
    return _instance.getString(key);
  }

  Future<bool> removeData({required String key}) async {
    return await _instance.remove(key);
  }
}
