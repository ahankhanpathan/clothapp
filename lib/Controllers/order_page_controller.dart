// order_page_controller.dart

import 'package:get/get.dart';
import 'package:clothapp/Controllers/order_controller.dart';
import 'package:clothapp/Models/product.dart';

class OrderPageController extends GetxController {
  final OrderController orderController = Get.find<OrderController>();

  List<Product> get orders => orderController.orderItems.toList();

  void clearOrders() {
    orderController.orderItems.clear();
  }
}
