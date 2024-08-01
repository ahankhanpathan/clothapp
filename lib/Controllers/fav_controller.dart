import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/product.dart';

class FavController extends GetxController {
  var favItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavFromPreferences();
  }

  void addFav(Product item) async {
    if (favItems.contains(item)) {
      favItems.remove(item);
    } else {
      favItems.add(item);
    }
    await saveFavToPreferences();
  }

  Future<void> saveFavToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(favItems.map((item) => item.toJson()).toList());
    await prefs.setString('favorites', jsonString);
  }

  Future<void> loadFavFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final favListString = prefs.getString('favorites');

    if (favListString != null) {
      try {
        final favListJson = jsonDecode(favListString) as List?;
        if (favListJson != null) {
          favItems.value = favListJson.map((item) => Product.fromJson(item)).toList();
        }
      } catch (e) {
        print("Error loading favorites from preferences: $e");
      }
    }
  }
}
