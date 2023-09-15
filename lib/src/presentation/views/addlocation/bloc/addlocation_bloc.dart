import 'package:bloc/bloc.dart';

part 'addlocation_event.dart';
part 'addlocation_state.dart';

class AddlocationBloc extends Bloc<AddlocationEvent, AddlocationState> {
  AddlocationBloc() : super(AddlocationState(city: '')) {
    on<AddlocationEvent>((event, emit) {});
  }
}
