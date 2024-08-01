// ignore_for_file: sort_child_properties_last, deprecated_member_use, prefer_const_constructors
import 'package:clothapp/Views/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/strings.dart';

class SuccessScreen extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  // ignore: use_super_parameters
  const SuccessScreen({
    required this.image,
    required this.title,
    required this.subTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(image),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              subTitle,
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(HomeScreen());
              },
              child: const Text(
                Strings.contin,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
