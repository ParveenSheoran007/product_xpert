// import 'package:flutter/material.dart';
// import 'package:product_xpert/model/produt_model.dart';
// import 'package:product_xpert/service/product_service.dart';
//
// class ProductProvider extends ChangeNotifier {
//   final ProductService productService = ProductService();
//   List<ProductModel> productModel = [];
//
//   List<ProductModel> get products => productModel;
//
//   Future<void> fetchProducts() async {
//     try {
//       productModel = await productService.getProducts();
//       notifyListeners();
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   Future<void> addProduct(ProductModel product) async {
//     try {
//       await productService.addProduct(product);
//       await fetchProducts();
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   Future<void> updateProduct(ProductModel product) async {
//     try {
//       await productService.updateProduct(product);
//       await fetchProducts();
//     } catch (e) {
//       throw e;
//     }
//   }
//
//   Future<void> deleteProduct(String productId) async {
//     try {
//       await productService.deleteProduct(productId);
//       await fetchProducts();
//     } catch (e) {
//       throw e;
//     }
//   }
// }
