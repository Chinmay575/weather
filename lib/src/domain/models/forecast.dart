import 'dart:convert';

import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForecastHour {
  double tempratureC;
  String time;
  String image;
  String text;
  ForecastHour({
    required this.tempratureC,
    required this.time,
    required this.image,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tempratureC': tempratureC,
      'time': time,
      'image': image,
      'text': text,
    };
  }

  factory ForecastHour.fromMap(Map<String, dynamic> map) {
    String time = DateFormat.jm().format(DateTime.parse(map['time']));
    String img = map['condition']['icon'];
    return ForecastHour(
      tempratureC: map['temp_c'] as double,
      time: time,
      image: img.replaceFirst('//cdn.weatherapi.com', 'assets'),
      text: map['condition']['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastHour.fromJson(String source) =>
      ForecastHour.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ForecastDay {
  String date;
  double maxTempC;
  double minTempC;
  double avgTempC;
  String text;
  String image;
  List<ForecastHour> hourly;
  ForecastDay({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.text,
    required this.image,
    required this.hourly,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'maxTempC': maxTempC,
      'minTempC': minTempC,
      'avgTempC': avgTempC,
      'text': text,
      'image': image,
      'hourly': hourly.map((x) => x.toMap()).toList(),
    };
  }

  factory ForecastDay.fromMap(Map<String, dynamic> map) {
    String img = map['day']['condition']['icon'] as String;
    DateTime date = DateTime.parse(map['date']);
    String d = "${date.day}/${date.month}";
    return ForecastDay(
      date: d,
      maxTempC: map['day']['maxtemp_c'] as double,
      minTempC: map['day']['mintemp_c'] as double,
      avgTempC: map['day']['avgtemp_c'] as double,
      text: map['day']['condition']['text'] as String,
      image: img.replaceFirst('//cdn.weatherapi.com', 'assets'),
      hourly: List<ForecastHour>.from(
        (map['hour'] as List<dynamic>).map<ForecastHour>(
          (x) => ForecastHour.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastDay.fromJson(String source) =>
      ForecastDay.fromMap(json.decode(source) as Map<String, dynamic>);
}
