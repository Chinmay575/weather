import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/src/utils/constants.dart';

class API {
  static getCurrentWeather({Position? p,String? city,String mode = 'city'}) async {
    String data = await rootBundle.loadString(AppAssets.apiKey);
    String apiKey = jsonDecode(data)["API_KEY"]; 
    // print(mode);
    // print(api_key);
    String url = (mode == 'city') ? "${AppStrings.baseUrl}?q=$city&key=$apiKey&tp=15&days=1" : "${AppStrings.baseUrl}?q=${p!.latitude},${p.longitude}&key=$apiKey&days=7";
    // print(url);
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent': 'PostmanRuntime/7.32.3',
      },
    );
    if(response.statusCode == 200)
    {
      // print("It works");
      // print(jsonDecode(response.body));
      return jsonDecode(response.body) as Map<String,dynamic>;
    }
  }
}
