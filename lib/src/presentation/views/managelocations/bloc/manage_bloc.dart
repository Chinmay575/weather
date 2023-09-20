import 'package:bloc/bloc.dart';
import 'package:weather/src/config/global.dart';
import 'package:weather/src/utils/constants.dart';

part 'manage_event.dart';
part 'manage_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc() : super(ManageState(locs: [])) {
    on<GetLocationEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            locs: Global.prefs.getStringList(AppStrings.locations),
          ),
        );
      },
    );
    on<AddLocationEvent>(
      (event, emit) async {
        await Global.prefs.addStringList(AppStrings.locations, event.city);
        emit(
          state.copyWith(
            locs: Global.prefs.getStringList(AppStrings.locations),
          ),
        );
      },
    );
    on<DeleteLocationEvent>(
      (event, emit) async {
        await Global.prefs.removeStringList(AppStrings.locations, event.city);
        emit(
          state.copyWith(
            locs: Global.prefs.getStringList(AppStrings.locations),
          ),
        );
      },
    );
    on<SetDefaultLocationEvent>(
      (event, emit) async {
        await Global.prefs.setString(AppStrings.defaultLocation, event.city);
        emit(state);
      },
    );
  }
}
