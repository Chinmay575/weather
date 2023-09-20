import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/config/global.dart';
import 'package:weather/src/presentation/widgets/widgets.dart';
import 'package:weather/src/utils/constants.dart';

import 'bloc/manage_bloc.dart';

class ManageLocationsPage extends StatefulWidget {
  const ManageLocationsPage({super.key});

  @override
  State<ManageLocationsPage> createState() => _ManageLocationsPageState();
}

class _ManageLocationsPageState extends State<ManageLocationsPage> {
  late double deviceHeight, deviceWidth;

  @override
  void initState() {
    BlocProvider.of<ManageBloc>(context).add(GetLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Manage Locations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocConsumer<ManageBloc, ManageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.locs.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<ManageBloc>(context).add(
                                  SetDefaultLocationEvent(
                                    city: Global.prefs.getString(
                                      AppStrings.currentLocation,
                                    ),
                                  ),
                                );
                                Navigator.popAndPushNamed(
                                    context, AppRoutes.home);
                              },
                              child: locationCard(
                                  Global.prefs.getString(
                                    AppStrings.currentLocation,
                                  ),
                                  true),
                            );
                          } else {
                            if (Global.prefs.getString(
                                  AppStrings.currentLocation,
                                ) !=
                                state.locs[index - 1]) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ManageBloc>(context).add(
                                    SetDefaultLocationEvent(
                                      city: state.locs[index - 1],
                                    ),
                                  );
                                  Navigator.popAndPushNamed(
                                    context,
                                    AppRoutes.home,
                                  );
                                },
                                onLongPress: () {
                                  BlocProvider.of<ManageBloc>(context).add(
                                    DeleteLocationEvent(
                                      city: state.locs[index - 1],
                                    ),
                                  );
                                },
                                child:
                                    locationCard(state.locs[index - 1], false),
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              addLocationButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationCard(String data, bool isCurrent) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      width: deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(data),
          Icon(
            Icons.location_on,
            color: (isCurrent) ? Colors.black : Colors.transparent,
          )
        ],
      ),
    );
  }
}
