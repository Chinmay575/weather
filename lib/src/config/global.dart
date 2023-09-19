import 'package:flutter/material.dart';
import 'package:weather/src/data/datasources/local/prefs.dart';

class Global {
  static late UserPrefences userPrefences;
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    userPrefences = await UserPrefences().init();
  }
}
