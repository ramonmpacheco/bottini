import 'package:bottini/views/products_overview_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BottiniApp());

class BottiniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Bottini',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductOverviewScreen(),
    );
  }
}
