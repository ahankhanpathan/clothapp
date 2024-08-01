import 'package:dio/dio.dart';
import '../Models/product.dart';

class APIService {
  static final Dio _dio = Dio();

  static Future<List<Product>?> fetchProducts() async {
    try {
      Response response = await _dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('Products fetched successfully: $data');
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return null;
    }
  }
  
  static Future<List<Product>?> fetchProductsByCategory(String category) async {
    try {
      Response response = await _dio.get('https://fakestoreapi.com/products/category/$category');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('Products by category fetched successfully: $data'); // Debug print
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products by category: $e');
      return null;
    }
  }
}
