import 'package:bloc/bloc.dart';
import 'package:weather/src/config/global.dart';
import 'package:weather/src/data/datasources/local/location.dart';
import 'package:weather/src/data/datasources/remote/api.dart';
import 'package:weather/src/domain/models/weather.dart';
import 'package:weather/src/utils/constants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<GetWeatherInfoEvent>(
      (event, emit) async {
        emit(LoadingState());
        String city = await Location.determinePosition();
        Weather w;
        String defaultLocation = Global.prefs.getString(
          AppStrings.defaultLocation,
        );
        print(defaultLocation);
        if (defaultLocation.isNotEmpty) {
          w = Weather.fromMap(
            await API.getCurrentWeather(
              city: defaultLocation,
            ),
          );
        } else {
          w = Weather.fromMap(
            await API.getCurrentWeather(city: city),
          );
        }
        await Global.prefs.setString(AppStrings.currentLocation, w.city);
        emit(HomeStateLoaded(weather: w));
      },
    );
  }
}
