import 'package:bottini/data/dummy_data.dart';
import 'package:bottini/models/product.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = DUMMY_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja Bottini'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, index) => Text(loadedProducts[0].title),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
