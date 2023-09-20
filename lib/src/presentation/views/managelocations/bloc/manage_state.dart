// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_bloc.dart';

class ManageState {
  List<String> locs;
  ManageState({
    required this.locs,
  });

  ManageState copyWith({
    List<String>? locs,
  }) {
    return ManageState(
      locs: locs ?? this.locs,
    );
  }
}

