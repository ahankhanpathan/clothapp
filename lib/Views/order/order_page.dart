// order_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clothapp/Controllers/order_page_controller.dart';
import 'package:clothapp/Models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/strings.dart';

class OrderPage extends StatelessWidget {
  final OrderPageController orderPageController = Get.put(OrderPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(Strings.orders,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: orderPageController.orders.length,
                itemBuilder: (context, index) {
                  Product order = orderPageController.orders[index];
                  return FutureBuilder<String?>(
                    future: _getDeliveryDate(order.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text( Strings.error +' ${snapshot.error}');
                      } else {
                        String? deliveryDate = snapshot.data;
                        return ListTile(
                          leading: Image.network(order.image!), 
                          title: Text(order.title ?? ''), 
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${order.price ?? 0.0}'), 
                              Text( Strings.arrvingdate +' $deliveryDate'), 
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              orderPageController.clearOrders(); 
            },
            child: Text('Clear Orders'),
          ),
        ],
      ),
    );
  }

Future<String?> _getDeliveryDate(int? productId) async {
  if (productId == null) {
    return null; 
  }
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = prefs.getString(productId.toString());
  if (data != null) {
    Map<String, dynamic> jsonData = json.decode(data);
    return jsonData['deliveryDate'];
  }
  return null;
}

}
