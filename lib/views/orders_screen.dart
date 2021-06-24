import 'package:flutter/material.dart';

import 'app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      drawer: AppDrawer(),
    );
  }
}
