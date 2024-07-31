import 'package:flutter/material.dart';
import 'package:news_and_weather/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), (() async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }));
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
