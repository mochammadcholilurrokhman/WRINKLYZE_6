import 'package:flutter/material.dart';
import 'package:wrinklyze_6/main.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9EEF0),
      body: Center(
        child: Image.asset(
          'assets/images/splash_logo.png',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}
