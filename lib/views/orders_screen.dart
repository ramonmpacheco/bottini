import 'package:bottini/providers/orders.dart';
import 'package:bottini/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Orders>(context, listen: false).loadOrders().then((_) {
      setState(() {
        this._isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.itemsCount,
              itemBuilder: (ctx, index) => OrderWidget(orders.items[index]),
            ),
      drawer: AppDrawer(),
    );
  }
}
