import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/strings.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedInStatus(); 
  }

  Future<void> checkLoggedInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {
      
      Get.offNamed('/home');
    }
  }

 Future<String?> login() async {
  if (usernameController.text.isEmpty) {
    return Strings.emailValidation;
  }
  if (passwordController.text.isEmpty) {
    return Strings.pwdValidation;
  }

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final savedAdminUsername = 'admin';
  final savedAdminPassword = 'password'; 

  final savedUsername = prefs.getString("LoggedInUsername");
  final savedPassword = prefs.getString("LoggedInPassword");

  if (usernameController.text == savedAdminUsername && passwordController.text == savedAdminPassword) {
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("LoggedInUsername", savedAdminUsername);
    Get.offNamed('/home');
    clearControllers();
    return null;
  } else if (usernameController.text == savedUsername && passwordController.text == savedPassword) {
    await prefs.setBool("isLoggedIn", true); 
    Get.offNamed('/home');
    clearControllers();
    return null;
  } else {
    return Strings.invalid;
  }
}

Future<String?> signup() async {
  if (usernameController.text.isEmpty) {
    return Strings.emailValidation;
  }
  
  if (passwordController.text.isEmpty) {
    return Strings.pwdValidation;
  }
  
  if (passwordController.text.length < 8) {
    return Strings.pwdlengthValidation;
  }
  
  if (!RegExp(r'(?=.*[A-Z])').hasMatch(passwordController.text)) {
    return Strings.upvalid;
  }
  
  if (!passwordController.text.contains('@')) {
    return Strings.pwdsymbol;
  }
  
  if (passwordController.text != confirmPasswordController.text) {
    return Strings.pwdValidMatch;
  }

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("LoggedInUsername", usernameController.text);
  await prefs.setString("LoggedInPassword", passwordController.text);

  Get.offNamed('/login', arguments: {
    'LoggedInUsername': usernameController.text,
    'LoggedInPassword': passwordController.text,
  });

  clearControllers();
  
  return null;
}


  void clearControllers() {
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
