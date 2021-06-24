import 'package:bottini/providers/orders.dart';
import 'package:bottini/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, index) => OrderWidget(orders.items[index]),
      ),
      drawer: AppDrawer(),
    );
  }
}
