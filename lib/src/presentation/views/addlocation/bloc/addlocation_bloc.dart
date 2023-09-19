import 'package:bloc/bloc.dart';
import 'package:weather/src/data/datasources/remote/api.dart';
import 'package:weather/src/domain/models/location.dart';

part 'addlocation_event.dart';
part 'addlocation_state.dart';

class AddlocationBloc extends Bloc<AddlocationEvent, AddlocationState> {
  AddlocationBloc() : super(Initial()) {
    on<SearchEvent>((event, emit) async {
      emit(Loading());
      var response = await API.getCitiesList(input: event.input) as List<dynamic>;
      List<LocationModel> l = [];
      for(var i in response)
      {
        l.add(LocationModel.fromMap(i));
      } 
      if(response.isEmpty) {
        emit(NotFound());
      } else {
        emit(Loaded(response: l));
      }
    });
    on<SelectCityEvent>(
      (event, emit) {
        emit(Selected(city: event.city));
      },
    );
  }
}
