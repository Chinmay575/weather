// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState {
  HomeState();
}

class InitialState extends HomeState {
  InitialState();
}

class LoadingState extends HomeState {
  LoadingState();
}

class HomeStateLoaded extends HomeState {
  Weather? weather;

  HomeStateLoaded({
    this.weather,
  });

  HomeStateLoaded copyWith({
    Weather? weather,
  }) {
    return HomeStateLoaded(
      weather: weather ?? this.weather,
    );
  }
}

class HomeStateError extends HomeState {}
