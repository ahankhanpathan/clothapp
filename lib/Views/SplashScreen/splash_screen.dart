import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = prefs.getString("LoginData");
      if (data != null) {
        Get.offNamed(
            '/home'); // Replace the current route with the login screen
      } else {
        Get.offNamed(
            '/login'); // Replace the current route with the login screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/logo.png',
          width: 850, // Adjust width and height as needed
          height: 750,
        ),
      ),
    );
  }
}
