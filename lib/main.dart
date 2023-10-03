import 'package:flutter/material.dart';
import 'package:weather/src/config/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/config/themes.dart';

import 'src/config/global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppRouter.allBlocProviders()],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.defaultTheme,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
