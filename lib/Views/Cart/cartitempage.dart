
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/strings.dart';
import '/Models/product.dart';

class Cartitempage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments as Product;
   

    return Scaffold(
      appBar: AppBar(
                iconTheme: IconThemeData(
    color: Colors.white,
  ),

        title: Text(
          product.title!,
          overflow: TextOverflow.ellipsis,
          selectionColor: Colors.white,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
            SizedBox(height: 10),
            Text(
              product.title!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price!.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              Strings.reviews  +'${product.rating!.rate} (${product.rating!.count}' + Strings.reviews2,
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(height: 16),
            Text(
              Strings.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(product.description!),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
