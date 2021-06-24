import 'package:bottini/providers/cart.dart';
import 'package:bottini/providers/orders.dart';
import 'package:bottini/providers/products.dart';
import 'package:bottini/routes/app_routes.dart';
import 'package:bottini/views/cart_screen.dart';
import 'package:bottini/views/product_detail_screen.dart';
import 'package:bottini/views/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(BottiniApp());

class BottiniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Loja Bottini',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.CART_DETAIL: (ctx) => CartScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
