import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/auth_controller.dart';
import '../../constant/strings.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(Strings.login,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            TextFormField(
              controller: authController.usernameController,
              decoration: InputDecoration(
                label: const Text(Strings.username),  
                hintText: Strings.usernameEnter,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: authController.passwordController,
              decoration: InputDecoration(
                label: const Text(Strings.password),
                hintText: Strings.passwordEnter,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),
           const SizedBox(height: 15),
            ElevatedButton(
            onPressed: () {
                authController.login().then((message) {
                  if (message != null) {
                   
                    Get.snackbar(Strings.loginfailed, message,
                        snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
                  }
                });
              },
              child: const Text(Strings.ctaLogin,style: TextStyle(color: Colors.white),),
               style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                  ),
            ),
            TextButton(
              onPressed: () {
                Get.offNamed('/signup');
              },
              child: const Text(Strings.loginTitle,style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
