import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/features/todos/todoCubit.dart';
import 'package:internet_connection/screens/homeScreen.dart';
import 'package:internet_connection/screens/widgets/internetListenerWidget.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => BlocProvider<TodoCubit>(
                create: (context) => TodoCubit(),
                child: HomeScreen(),
              )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InternetListenerWidget(
        onInternetConnectionBack: () {},
        child: Scaffold(
          appBar: AppBar(
            title: Text("Splash screen"),
          ),
        ));
  }
}
