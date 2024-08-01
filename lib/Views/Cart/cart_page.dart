import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/cart_controller.dart';
import '../../Models/product.dart';
import '../../constant/strings.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                iconTheme: IconThemeData(
    color: Colors.white,
  ),

        title: Text(Strings.cart,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      backgroundColor: Colors.red,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text(Strings.emptyCart));
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    Product item = cartController.cartItems[index];
                    return Card(
                      color: Colors.red[100],
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Image.network(
                                item.image!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                item.title!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('\$${item.price!.toStringAsFixed(2)}'),
                                ],
                              ),
                              onTap: () {
                                Get.toNamed('/cartitem', arguments: item);
                              },
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle),
                                color: Colors.red,
                                onPressed: () {
                                  cartController.decrementQuantity(item);
                                },
                              ),
                              Text('${item.quantity ?? 1}'),
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                color: Colors.green,
                                onPressed: () {
                                  cartController.incrementQuantity(item);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), 
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Strings.summary,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         const Text(
                            Strings.subtotal,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                          color: Colors.white,

                            ),
                          ),
                          Text(
                            '\$${cartController.Subtotal.value.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16,
                          color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const  Text(
                         Strings.discount,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                          color: Colors.white,

                            ),
                          ),
                          Text(
                            '\$${cartController.discount.value.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16,
                          color: Colors.white,

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(), 
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.total,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          color: Colors.white,

                            ),
                          ),
                          Text(
                            '\$${cartController.totalAmount.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          color: Colors.white,

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/checkout',arguments: cartController.cartItems.first);
                  },
                  child: Text(
                    Strings.paycheck,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
