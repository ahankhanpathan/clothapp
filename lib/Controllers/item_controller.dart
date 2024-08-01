import 'package:get/get.dart';
import '../Models/product.dart';

class ItemController extends GetxController {
  var selectedItem;

  void setSelectedItem(Product item) {
    selectedItem.value = item;
  }

}
