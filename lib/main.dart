import 'package:bottini/providers/auth.dart';
import 'package:bottini/providers/cart.dart';
import 'package:bottini/providers/orders.dart';
import 'package:bottini/providers/products.dart';
import 'package:bottini/routes/app_routes.dart';
import 'package:bottini/views/auth_home_screen.dart';
import 'package:bottini/views/cart_screen.dart';
import 'package:bottini/views/orders_screen.dart';
import 'package:bottini/views/product_detail_screen.dart';
import 'package:bottini/views/product_from_screen.dart';
import 'package:bottini/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(BottiniApp());

class BottiniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(null, []),
          update: (ctx, auth, previousProducts) =>
              Products(auth.token, previousProducts.items),
        ),
      ],
      child: MaterialApp(
        title: 'Loja Bottini',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.CART_DETAIL: (ctx) => CartScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreem(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
