import 'package:bottini/routes/app_routes.dart';
import 'package:bottini/views/product_detail_screen.dart';
import 'package:bottini/views/products_overview_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BottiniApp());

class BottiniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Bottini',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen()},
    );
  }
}
