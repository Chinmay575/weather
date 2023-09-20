import 'package:flutter/material.dart';
import 'package:weather/src/data/datasources/local/prefs.dart';

class Global {
  static late UserPrefences prefs;
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await UserPrefences().init();
  }
}
