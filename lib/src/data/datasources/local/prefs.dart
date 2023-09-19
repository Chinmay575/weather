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

  Future<bool> getBoolean(String key) async {
    return _prefs.getBool(key) ?? false;
  }

  Future<String> getString(String key) async {
    return _prefs.getString(key) ?? '';
  }
  

}