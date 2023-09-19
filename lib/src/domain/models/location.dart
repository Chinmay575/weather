import 'dart:convert';
class LocationModel {
  String city;
  String country;
  LocationModel({
    required this.city,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'country': country,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      city: map['name'] as String,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
