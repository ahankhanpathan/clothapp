import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/strings.dart';

class Address {
  String street;
  String city;
  String state;
  String zip;

  Address({required this.street, required this.city, required this.state, required this.zip});
}

class AddressController extends GetxController {
  var addresses = <Address>[].obs;

  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  void addAddress() {
    addresses.add(Address(
      street: streetController.text,
      city: cityController.text,
      state: stateController.text,
      zip: zipController.text,
    ));
    clearControllers();
  }

  void editAddress(int index) {
    streetController.text = addresses[index].street;
    cityController.text = addresses[index].city;
    stateController.text = addresses[index].state;
    zipController.text = addresses[index].zip;

    Get.defaultDialog(
      title: Strings.editAddress,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: streetController, decoration: InputDecoration(labelText: 'Street')),
          TextField(controller: cityController, decoration: InputDecoration(labelText: 'City')),
          TextField(controller: stateController, decoration: InputDecoration(labelText: 'State')),
          TextField(controller: zipController, decoration: InputDecoration(labelText: 'Zip Code')),
        ],
      ),
      confirm: TextButton(
        onPressed: () {
          addresses[index] = Address(
            street: streetController.text,
            city: cityController.text,
            state: stateController.text,
            zip: zipController.text,
          );
          clearControllers();
          Get.back();
        },
        child: Text(Strings.save),
      ),
    );
  }

  void clearControllers() {
    streetController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
  }

 
}
