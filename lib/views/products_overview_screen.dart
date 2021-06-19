import 'package:bottini/widgets/product_grid.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja Bottini'),
      ),
      body: ProductGrid(),
    );
  }
}
