// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_bloc.dart';

abstract class ManageEvent {}

class GetLocationEvent extends ManageEvent {}

class AddLocationEvent extends ManageEvent {
  String city;
  AddLocationEvent({
    required this.city,
  });
}

class DeleteLocationEvent extends ManageEvent {
  String city;
  DeleteLocationEvent({
    required this.city,
  });
}

class SetDefaultLocationEvent extends ManageEvent {
  String city;
  SetDefaultLocationEvent({
    required this.city,
  });
}
