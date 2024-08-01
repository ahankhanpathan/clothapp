// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import '../../constant/strings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          Strings.settings,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.account_box),
                    title: Text(Strings.manageaccounts),
                    onTap: () {
                      // Get.toNamed('/profile');
                    },
                  ),
                  elevation: 0,
                  shadowColor: Colors.grey,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.create),
                    title: Text(Strings.data),
                    onTap: () {
                      // Get.toNamed('/fav');
                    },
                  ),
                   elevation: 0,
                  shadowColor: Colors.grey,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.password),
                    title: Text(Strings.security),
                    onTap: () {
                      // Get.toNamed('/address');
                    },
                  ),
                   elevation: 0,
                  shadowColor: Colors.grey,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.monetization_on_outlined),
                    title: Text(Strings.purchaseOp),
                    onTap: () {
                      // Get.toNamed('/settings');
                    },
                  ),
                   elevation: 0,
                  shadowColor: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
