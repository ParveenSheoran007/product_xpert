import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_xpert/model/produt_model.dart';

class ProductService {
  static const String baseUrl = 'http://localhost:3000/api/products';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<ProductModel> products =
        jsonData.map((item) => ProductModel.fromJson(item)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw e;
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 201) {
        // Success
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      print('Error adding product: $e');
      throw e;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final url = Uri.parse('$baseUrl/$productId');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw e;
    }
  }

  Future<ProductModel> fetchNewProductData() async {
    try {
      final response =
      await http.get(Uri.parse('http://your_api_endpoint/new_product'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        ProductModel newProduct = ProductModel.fromJson(jsonData);
        return newProduct;
      } else {
        throw Exception('Failed to fetch initial data for new product');
      }
    } catch (e) {
      print('Error fetching new product data: $e');
      throw e;
    }
  }
}
