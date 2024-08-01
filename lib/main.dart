import 'package:clothapp/Controllers/address_controller.dart';
import 'package:clothapp/Controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controllers/cart_controller.dart';
import 'Utils/route_generator.dart';
import 'Views/SplashScreen/splash_screen.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: SplashScreen(),
      getPages: RouteGenerator.getPages(),
      initialBinding: BindingsBuilder(() {
Get.put(APIService());
              Get.put(CartController());
              Get.put(OrderController());

               Get.put(AddressController());

      }),
    );
  }
}
