// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetWeatherInfoEvent extends HomeEvent {}

class GetCityInputEvent extends HomeEvent {
  String city;
  GetCityInputEvent({
    required this.city,
  });
}

class CityChangeEvent extends HomeEvent {}
