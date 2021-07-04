import 'dart:convert';
import 'dart:math';

import 'package:bottini/data/dummy_data.dart';
import 'package:bottini/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product newProduct) {
    var url = Uri.parse('minha_url');
    http.post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'ifFavorite': newProduct.isFavorite
      }),
    );

    _items.add(Product(
      id: Random().nextDouble().toString(),
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product != null && product.id == null) {
      return;
    }

    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final int index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      _items.removeWhere((product) => product.id == id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
