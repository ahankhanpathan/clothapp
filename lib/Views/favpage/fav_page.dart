import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/fav_controller.dart';
import '../../Models/product.dart';
import '../../constant/strings.dart';

class FavPage extends StatelessWidget {
  final FavController favController = Get.put(FavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                iconTheme: IconThemeData(
    color: Colors.white,
  ),

        title: Text(
          Strings.favourites,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Obx(() {
        if (favController.favItems.isEmpty) {
          return Center(child: Text(Strings.favEmp));
        } else {
          return ListView.builder(
            itemCount: favController.favItems.length,
            itemBuilder: (context, index) {
              Product item = favController.favItems[index];
              return ListTile(
                title: Text(item.title ?? ''),
                subtitle: Text('\$${item.price?.toStringAsFixed(2) ?? ""}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.image ?? ''),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () {
                    favController.addFav(item);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
