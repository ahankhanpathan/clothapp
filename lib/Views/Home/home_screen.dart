import 'package:clothapp/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          Strings.appName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
    ),
      body: Padding( 
        padding: EdgeInsets.only(top: 8.0), 
        child: Obx(() {
          return homeController.getSelectedWidget();
        }),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: homeController.selectedIndex.value,
          fixedColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              label: Strings.home,
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: Strings.search,
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: Strings.profile,
              icon: Icon(Icons.account_circle),
            ),
          ],
          onTap: homeController.onTap,
        );
      }),
    );
  }
}
