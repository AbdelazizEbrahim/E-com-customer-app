import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/product.dart';

class ApiService {
  Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
    required String brand,
    required String category,
    required bool inStock,
    required List<Map<String, String>> images,
    required List<String> reviews,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
          'brand': brand,
          'category': category,
          'inStock': inStock,
          'images': images,
          'reviews': reviews,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Product.fromJson(data['product']);
      } else {
        throw Exception(
          jsonDecode(response.body)['message'] ?? 'Failed to create product',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/products'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Product>.from(
          data['products'].map((json) => Product.fromJson(json)),
        );
      } else {
        throw Exception(
          jsonDecode(response.body)['message'] ?? 'Failed to fetch products',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
