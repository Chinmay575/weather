// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addlocation_bloc.dart';

class AddlocationState {}

class Initial extends AddlocationState {}

class Loading extends AddlocationState {}

class Loaded extends AddlocationState {
  List<LocationModel> response;
  Loaded({
    required this.response,
  });
}

class Selecting extends AddlocationState {}

class Selected extends AddlocationState {
  String city;
  Selected({
    required this.city,
  });
}

class NotFound extends AddlocationState {}