import 'dart:convert';
import 'package:clothapp/Models/product.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var totalAmount = 0.0.obs;
  var Subtotal = 0.0.obs;
  var discount = 0.0.obs; 

  @override
  void onInit() {
    super.onInit();
    loadCartFromPreferences();
  }

void addItemToCart(Product item) async {
  var existingItem = cartItems.firstWhereOrNull((element) => element.id == item.id);
  if (existingItem != null) {
    existingItem.quantity = (existingItem.quantity ?? 0) + 1;
  } else {
    item.quantity = 1;
    cartItems.add(item);
  }
  updateSubtotal();
  await saveCartToPreferences();
}
 
  void removeItemFromCart(Product item) async {
    if (item.quantity! > 1) {
      item.quantity = (item.quantity ?? 1) - 1;
    } else {
      cartItems.remove(item);
    }
    updateSubtotal();
    await saveCartToPreferences();
  }

  void incrementQuantity(Product item) async {
    item.quantity = (item.quantity ?? 0) + 1;
    updateSubtotal();
    await saveCartToPreferences();
  }

void decrementQuantity(Product item) async {
  if (item.quantity! > 1) {
    item.quantity = (item.quantity ?? 1) - 1;
  } else {
    cartItems.remove(item);
  }
  updateSubtotal();
  await saveCartToPreferences();
}
  
  void updateSubtotal() {
    Subtotal.value = cartItems.fold(0.0, (sum, item) => sum + (item.price ?? 0.0) * (item.quantity ?? 1));
    updateTotalAmount();
  }

  void updateTotalAmount() {
    totalAmount.value = Subtotal.value - discount.value;
  }

  Future<void> saveCartToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cart', jsonString);
  }

  Future<void> loadCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartListString = prefs.getString('cart');

    if (cartListString != null) {
      try {
        final cartListJson = jsonDecode(cartListString) as List?;
        if (cartListJson != null) {
          cartItems.value = cartListJson.map((item) => Product.fromJson(item)).toList();
          updateSubtotal();
        }
      } catch (e) {
        print("Error loading cart from preferences: $e");
      }
    }
  }

  void setDiscount(double discountValue) {
    discount.value = discountValue;
    updateTotalAmount();
  }
}
