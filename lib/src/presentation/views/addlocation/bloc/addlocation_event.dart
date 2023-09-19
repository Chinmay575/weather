// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addlocation_bloc.dart';

abstract class AddlocationEvent {}

class SearchEvent extends AddlocationEvent {
  String input;
  SearchEvent({
    required this.input,
  });
}

class SelectCityEvent extends AddlocationEvent {
  String city;
  SelectCityEvent({
    required this.city,
  });
}
