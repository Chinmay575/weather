import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/presentation/views/addlocation/addlocation.dart';
import 'package:weather/src/presentation/views/addlocation/bloc/addlocation_bloc.dart';
import 'package:weather/src/presentation/views/home/bloc/home_bloc.dart';
import 'package:weather/src/presentation/views/home/home.dart';
import 'package:weather/src/presentation/views/managelocations/bloc/manage_bloc.dart';
import 'package:weather/src/presentation/views/managelocations/managelocations.dart';
import 'package:weather/src/utils/constants.dart';

class AppRouter {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.home,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (context) => HomeBloc()..add(GetWeatherInfoEvent()),
          lazy: false,
        ),
      ),
      PageEntity(
        route: AppRoutes.addLocation,
        page: const AddLocationPage(),
        bloc: BlocProvider(
          create: (context) => AddlocationBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.manageLocations,
        page: const ManageLocationsPage(),
        bloc: BlocProvider(
          create: (context) => ManageBloc(),
        ),
      ),
    ];
  }

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  static List<dynamic> allBlocProviders() {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({
    required this.route,
    required this.page,
    required this.bloc,
  });
}
