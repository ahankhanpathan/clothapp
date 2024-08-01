// import 'package:clothapp/Views/Auth/login_screen.dart';
import '../Views/Search/search_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Views/Home/home_section.dart';
import '../Views/profile/ProfilePage.dart';
import '../services/api_service.dart';
import '../Models/product.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var productList = <Product>[].obs;
  var categoryList = <String>[].obs;
  var isLoading = true.obs;
  var selectedCategory = ''.obs;
  var selectedIndex = 0.obs;
  var username = ''.obs;


  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    loadUserData();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await APIService.fetchProducts();
      if (products != null) {
        productList.assignAll(products);
      }
    } catch (e) {
      print("Error in fetchProducts: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchProductsByCategory(String category) async {
    try {
      isLoading(true);
      selectedCategory(category);
      var products = await APIService.fetchProductsByCategory(category);
      if (products != null) {
        productList.assignAll(products);
      }
    } catch (e) {
      print("Error in fetchProductsByCategory: $e");
    } finally {
      isLoading(false);
    }
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username(prefs.getString("LoggedInUsername") ?? '');
  }

 Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("AuthToken");
    await prefs.setBool("isLoggedIn", false); 
    Get.offAllNamed('/login');
  }



  void onTap(int index) {
    selectedIndex(index);
  }

  Widget getSelectedWidget() {
    switch (selectedIndex.value) {
      case 0:
        return HomeSection();
      case 1:
        return SearchScreen();
      case 2:
        return ProfilePage(username: username.value);
      default:
        return SizedBox();
    }
  }
}
