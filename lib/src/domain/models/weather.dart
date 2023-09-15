// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weather/src/domain/models/forecast.dart';

class Weather {
  String location;
  String condition;
  int humidity;
  double tempratureC;
  double uvIndex;
  double windK;
  String image;
  double pressuremb;
  double gustK;
  String sunrise;
  String sunset;
  int rain;
  List<ForecastDay> forecast7Day;
  Weather({
    required this.rain,
    required this.sunrise,
    required this.sunset,
    required this.gustK,
    required this.pressuremb,
    required this.location,
    required this.condition,
    required this.humidity,
    required this.tempratureC,
    required this.uvIndex,
    required this.image,
    required this.windK,
    required this.forecast7Day,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'condition': condition,
      'humidity': humidity,
      'tempratureC': tempratureC,
      'uvIndex': uvIndex,
      'windK': windK,
      'image': image,
      'pressuremb': pressuremb,
      'gustK': gustK,
      'sunrise': sunrise,
      'sunset': sunset,
      'rain': rain,
      'forecast7Day': forecast7Day.map((x) => x.toMap()).toList(),
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    String img = map['current']['condition']['icon'];
    List<dynamic> forecast = map['forecast']['forecastday'] as List<dynamic>;
    return Weather(
      rain: forecast[0]['day']['daily_chance_of_rain'] as int,
      location: map['location']['name'] + ',' + map['location']['country'],
      condition: map['current']['condition']['text'] as String,
      humidity: map['current']['humidity'] as int,
      tempratureC: map['current']['temp_c'] as double,
      uvIndex: map['current']['uv'] as double,
      windK: map['current']['wind_kph'] as double,
      pressuremb: map['current']['pressure_mb'] as double,
      gustK: map['current']['gust_kph'] as double,
      sunrise: forecast[0]['astro']['sunrise'] as String,
      sunset: forecast[0]['astro']['sunset'] as String,
      image: img.replaceFirst('//cdn.weatherapi.com', 'assets'),
      forecast7Day: List<ForecastDay>.from(
        (map['forecast']['forecastday'] as List<dynamic>).map<ForecastDay>(
          (x) => ForecastDay.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);
}
