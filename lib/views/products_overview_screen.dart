import 'package:bottini/providers/cart.dart';
import 'package:bottini/routes/app_routes.dart';
import 'package:bottini/views/app_drawer.dart';
import 'package:bottini/widgets/badge.dart';
import 'package:bottini/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { FAVORITE, ALL }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja Bottini'),
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART_DETAIL);
              },
            ),
            builder: (_, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.FAVORITE) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.FAVORITE,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.ALL,
              ),
            ],
          ),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
