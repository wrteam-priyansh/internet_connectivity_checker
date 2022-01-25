import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/features/internetConnectivityCubit.dart';

import 'package:internet_connection/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetConnectivityCubit>(
            create: (_) => InternetConnectivityCubit()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
