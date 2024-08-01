  import '../../Controllers/home_controller.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

import '../../constant/strings.dart';

  class ProfilePage extends StatelessWidget {
    final String username;

    ProfilePage({Key? key, required this.username}) : super(key: key);

    final HomeController homeController = Get.put(HomeController());

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                        // Get.toNamed('/profile');
                            
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/user.jpg'),
                            
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome, $username ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text(Strings.myorder),
                    onTap: () {
                      Get.toNamed('/orders');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(Strings.favourites),
                    onTap: () {
                      Get.toNamed('/fav');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(Strings.address),
                    onTap: () {
                      Get.toNamed('/address');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(Strings.settings),
                    onTap: () {
                      Get.toNamed('/settings');
                    },
                  ),
                  SizedBox(height: 220),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(Strings.logout),
                    onTap: () {
                      homeController.logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
