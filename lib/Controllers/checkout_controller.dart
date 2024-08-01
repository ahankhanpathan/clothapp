import 'dart:async';
import 'package:clothapp/Controllers/home_controller.dart';
import 'package:clothapp/Controllers/order_controller.dart';
import 'package:clothapp/Controllers/timer.dart';
import 'package:clothapp/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Views/Success Screen/success_screen.dart';
import '../constant/strings.dart';

class CheckoutPageController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final OrderController orderController = Get.find<OrderController>();

  final Product product = Get.arguments as Product;

  var selectedPaymentMethod = ''.obs;
  var selectedBank = Strings.selectedBank.obs;

  void setPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> showLoadingDialog() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    await Future.delayed(Duration(seconds: 2));
    Get.back();
  }

  void proceedToPayment(RxList<Product> cartItems) {
    if (selectedPaymentMethod.value.isNotEmpty) {
      if (selectedPaymentMethod.value == Strings.upi) {
        handleUPIPayment(cartItems);
      } else if (selectedPaymentMethod.value == Strings.netBanking) {
        handleNetBankingPayment(cartItems);
      } else if (selectedPaymentMethod.value == Strings.cod) {
        handleCODPayment(cartItems);
      }
    } else {
      Get.snackbar(
        Strings.error,
        Strings.paymentselect,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void handleUPIPayment(RxList<Product> cartItems) async {
    await showLoadingDialog();
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/QR.png', width: 200, height: 200),
            SizedBox(height: 16),
            CountdownTimer(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar(Strings.checkoutFailed, Strings.checkoutUpi,
                    backgroundColor: Colors.red, colorText: Colors.white);
              },
              child: Text(Strings.cancel),
            ),
          ],
        ),
      ),
    );
    await Future.delayed(Duration(seconds: 120));
    Get.back();
    Get.snackbar(Strings.checkoutFailed, Strings.checkoutUpi,
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void handleNetBankingPayment(RxList<Product> cartItems) async {
    await showLoadingDialog();
    Get.dialog(
      AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: selectedBank.value,
                  onChanged: (value) {
                    setState(() {
                      selectedBank.value = value!;
                    });
                  },
                  items: [
                    Strings.selectedBank,
                    Strings.sbi,
                    Strings.bob,
                    Strings.hdfc,
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                if (selectedBank.value != Strings.selectedBank)
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        Strings.enterIFSC,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Strings.IFSC,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (selectedBank.value == Strings.selectedBank) {
                      Get.snackbar(
                        Strings.error,
                        Strings.paymentselectBank,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      saveOrder(cartItems);
                      Get.snackbar(
                        Strings.paymentSuccess,
                        Strings.itemMess,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      Get.to(() => const SuccessScreen(
                            image: 'images/success.png',
                            title: Strings.paymentSuccess,
                            subTitle: Strings.itemMess,
                          ));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                  ),
                  child: const Text(
                    Strings.confirm,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      Strings.checkoutFailed,
                      Strings.checkoutFailedMess,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  },
                  child: Text(
                    Strings.cancel,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void handleCODPayment(RxList<Product> cartItems) async {
    saveOrder(cartItems);
     Get.snackbar(
                        Strings.paymentSuccess,
                        Strings.itemMess,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
    Get.to(() => SuccessScreen(
          image: 'images/success.png',
          title: Strings.paymentSuccess,
          subTitle: Strings.itemMess,
        ));

    
  }


  void saveOrder(RxList<Product> cartItems) {
    cartItems.forEach((item) {
      orderController.addOrder(item);
    });
  }
}
