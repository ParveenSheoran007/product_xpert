import 'package:flutter/material.dart';
import 'package:product_xpert/model/produt_model.dart';
import 'package:product_xpert/service/product_service.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _productService = ProductService();
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> fetchedProducts = await _productService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
      // Handle error as needed
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productService.deleteProduct(productId);
      await fetchProducts(); // Refresh products list after deletion
    } catch (e) {
      print('Error deleting product: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModel product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            // Example: Add edit and delete functionalities
            // Example: onLongPress to delete
            onLongPress: () {
              deleteProduct(product.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fetch initial data for new product from API
          showDialog(
            context: context,
            builder: (context) => FutureBuilder<ProductModel>(
              future: _productService.fetchNewProductData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Example: Save product and refresh list
                  ProductModel newProduct = snapshot.data!;
                  addProduct(newProduct);
                  Navigator.pop(context); // Close dialog
                  return SizedBox.shrink();
                }
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
