import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/presentation/views/addlocation/bloc/addlocation_bloc.dart';
import 'package:weather/src/presentation/views/managelocations/bloc/manage_bloc.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  TextEditingController textEditingController = TextEditingController();
  late double deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.read<AddlocationBloc>().add(
                          SearchEvent(input: textEditingController.value.text));
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              BlocConsumer<AddlocationBloc, AddlocationState>(
                listener: (context, state) {
                  if (state is Selected) {
                    BlocProvider.of<ManageBloc>(context)
                        .add(AddLocationEvent(city: state.city));
                  }
                },
                builder: (context, state) {
                  if (state is Loading) {
                    return SizedBox(
                      height: deviceHeight * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is Loaded) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: deviceHeight * 0.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.response.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AddlocationBloc>(context)
                                        .add(
                                      SelectCityEvent(
                                        city: state.response[index].city,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[300],
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.only(left: 10),
                                    width: deviceWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${state.response[index].city},${state.response[index].country}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is NotFound) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "No city found with ${textEditingController.value.text},try rechecking it or try searching nearby cities.",
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Go Back"),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
