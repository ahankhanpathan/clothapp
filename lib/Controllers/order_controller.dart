import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/product.dart';

class OrderController extends GetxController {
  var orderItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrdersFromPreferences();
  }

  void addOrder(Product item) async {
    orderItems.add(item);
    await saveOrdersToPreferences();
  }

  Future<void> saveOrdersToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(orderItems.map((item) => item.toJson()).toList());
    await prefs.setString('orders', jsonString);
  }

  Future<void> loadOrdersFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final orderListString = prefs.getString('orders');

    if (orderListString != null) {
      try {
        final orderListJson = jsonDecode(orderListString) as List?;
        if (orderListJson != null) {
          orderItems.value = orderListJson.map((item) => Product.fromJson(item)).toList();
        }
      } catch (e) {
        print("Error loading orders from preferences: $e");
      }
    }
  }

}

