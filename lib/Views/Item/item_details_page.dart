// ignore_for_file: deprecated_member_use

import '../../Controllers/cart_controller.dart';
import '../../Controllers/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/strings.dart';
import '/Models/product.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments as Product;
    final CartController cartController = Get.put(CartController());
    final FavController favController = Get.put(FavController());

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
    color: Colors.white, //change your color here
  ),

        title: Text(
          product.title!,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis, 
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite,color: Colors.white,),
            onPressed: () {
              Get.toNamed('/fav');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: () {
              Get.toNamed('/cart');
            },
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image!,
              height: 220,
              width: 250,
            ),
            const SizedBox(height: 10),
            Text(
              product.title!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price!.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 25, color: Colors.red,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              Strings.reviews +' ${product.rating!.rate} (${product.rating!.count})'+ Strings.reviews2,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            const Text(
             Strings.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description!),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    favController.addFav(product);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          horizontal: 11.0, vertical: 8.0), 
                    ),
                  ),
                  child: const Text(
                    Strings.addFav,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    cartController.addItemToCart(product);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                  ),
                  child: const Text(
                  Strings.addCart,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
