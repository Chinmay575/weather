import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/src/data/datasources/local/location.dart';
import 'package:weather/src/data/datasources/remote/api.dart';
import 'package:weather/src/domain/models/weather.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<GetWeatherInfoEvent>(
      (event, emit) async {
        emit(LoadingState());
        Position p = await Location.determinePosition();
        Weather w =  Weather.fromMap(await API.getCurrentWeather(p: p,mode: 'cords'));
        List<String> cities = [];
        cities.add(w.city);
        emit(HomeStateLoaded(weather: w,cities: cities));
      },
    );
    on<AddNewCityEvent>((event, emit) async {
      List<String> cities = [];
      Weather w =  Weather.fromMap(await API.getCurrentWeather(city: event.city,mode: 'city'));
      cities.add(event.city);
      emit(HomeStateLoaded().copyWith(weather: w,cities: cities));
    },);
  }
}
