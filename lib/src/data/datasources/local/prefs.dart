import 'package:shared_preferences/shared_preferences.dart';

class UserPrefences {
  late final SharedPreferences _prefs;
  Future<UserPrefences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getBoolean(String key) {
    return _prefs.getBool(key) ?? false;
  }

  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  Future<bool> addStringList(String key, String value) async {
    List<String>? s = _prefs.getStringList(key) ?? [];
    if (!s.contains(value)) {
      s.add(value);
    }
    return await _prefs.setStringList(key, s);
  }

  Future<bool> removeStringList(String key, String value) async {
    List<String>? s = _prefs.getStringList(key) ?? [];
    if (s.isNotEmpty) s.remove(value);
    return await _prefs.setStringList(key, s);
  }

  List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }
}
