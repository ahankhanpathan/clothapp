import 'dart:convert';

import 'package:clothapp/Controllers/date_controller.dart';
import 'package:clothapp/Controllers/order_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/cart_controller.dart';
import '../../Controllers/checkout_controller.dart';
import '../../Models/product.dart';
import '../../constant/strings.dart';

final OrderPageController orderPageController = Get.put(OrderPageController());

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.find<CartController>();
  final CheckoutPageController checkoutController =
      Get.put(CheckoutPageController());
  final DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(Strings.checkout,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                Strings.selectedItem,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                Product item = cartController.cartItems[index];
                return Card(
                  child: ListTile(
                    title: Text(item.title ?? ''),
                    subtitle: Text('\$${item.price?.toStringAsFixed(2) ?? ""}'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.image ?? ''),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Total: \$${cartController.Subtotal.value.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.payme,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              checkoutController.setPaymentMethod(Strings.upi),
                          child: Card(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: Strings.upi,
                                  groupValue: checkoutController
                                      .selectedPaymentMethod.value,
                                  onChanged: (value) => checkoutController
                                      .setPaymentMethod(Strings.upi),
                                ),
                                Image.asset(
                                  'images/upi.png',
                                  width: 70,
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => checkoutController
                              .setPaymentMethod(Strings.netBanking),
                          child: Card(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: Strings.netBanking,
                                  groupValue: checkoutController
                                      .selectedPaymentMethod.value,
                                  onChanged: (value) => checkoutController
                                      .setPaymentMethod(Strings.netBanking),
                                ),
                                Icon(Icons.account_balance),
                                const Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        Strings.netBanking2,
                                        style: TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.fade,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              checkoutController.setPaymentMethod(Strings.cod),
                          child: Card(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: Strings.cod,
                                  groupValue: checkoutController
                                      .selectedPaymentMethod.value,
                                  onChanged: (value) => checkoutController
                                      .setPaymentMethod(Strings.cod),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  Strings.cod2,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                            
                              DateTime? pickedDate = await dateController
                                  .selectDeliveryDate(context);
                              if (pickedDate != null) {
                                for (var item in cartController.cartItems) {
                           
                                  Map<String, dynamic> data = {
                                    'product': item.toJson(),
                                    'deliveryDate': pickedDate.toString(),
                                  };

                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  await prefs.setString(
                                      item.id.toString(), json.encode(data));
                                }

                                dateController.selectedDate.value = pickedDate;
                              }
                            },
                            child: Text(
                              'Select Delivery Date',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.red), 
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Selected Delivery Date: ${dateController.selectedDate.value}',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  checkoutController.proceedToPayment(cartController.cartItems);
                },
                child: Text(
                  Strings.payment,
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
