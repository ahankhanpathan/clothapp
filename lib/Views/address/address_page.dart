import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/address_controller.dart';
import '../../constant/strings.dart';

class AddressScreen extends StatelessWidget {
  final AddressController addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          Strings.address,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: addressController.addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${addressController.addresses[index].street}, ${addressController.addresses[index].city}, ${addressController.addresses[index].state}, ${addressController.addresses[index].zip}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => addressController.editAddress(index),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                    controller: addressController.streetController,
                    decoration: InputDecoration(labelText: Strings.street)),
                TextField(
                    controller: addressController.cityController,
                    decoration: InputDecoration(labelText: Strings.city)),
                TextField(
                    controller: addressController.stateController,
                    decoration: InputDecoration(labelText: Strings.state)),
                TextField(
                    controller: addressController.zipController,
                    decoration: InputDecoration(labelText: Strings.zipcode)),
                ElevatedButton(
                  onPressed: addressController.addAddress,
                  child: Text(Strings.addAddress),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
