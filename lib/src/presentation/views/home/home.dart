import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/domain/models/weather.dart';
import 'package:weather/src/presentation/views/home/bloc/home_bloc.dart';

import '../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double deviceWidth, deviceHeight;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is InitialState) {
          return Scaffold(body: initialWidget());
        } else if (state is LoadingState) {
          return Scaffold(body: loadingWidget());
        } else if (state is HomeStateLoaded) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(GetWeatherInfoEvent());
                  },
                  icon: const Icon(Icons.refresh),
                )
              ],
            ),
            drawer: SafeArea(
              child: Drawer(
                child: locations(context,state.cities!),
              ),
            ),
            body: showWeatherInfo(state.weather!),
          );
        } else {
          return Scaffold(body: showError());
        }
      },
    );
  }

  showWeatherInfo(Weather w) {
    String lastUpdated = DateFormat.jms().format(DateTime.now());
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: displayWeather(w, lastUpdated, context),
        ),
        SliverToBoxAdapter(
          child: showForecast(context, w),
        ),
        SliverToBoxAdapter(
          child: showForecastNext7Days(context, w),
        ),
        SliverToBoxAdapter(
          child: extraDetails(w, context),
        ),
        SliverToBoxAdapter(
          child: sunRiseDetails(w, context),
        )
      ],
    );
  }
}
