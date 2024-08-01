import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

Future<DateTime?> selectDeliveryDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {

      selectedDate.value = pickedDate;


    }
    return pickedDate;

  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  bool isPastDate(DateTime date) {
    final currentDate = DateTime.now();
    return date.isBefore(currentDate);
  }
}
