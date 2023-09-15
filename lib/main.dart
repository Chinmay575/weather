import 'package:flutter/material.dart';
import 'package:weather/src/config/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/config/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppRouter.allBlocProviders(context)],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.defaultTheme,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
