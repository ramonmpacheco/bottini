import 'dart:convert';

import 'package:bottini/data/dummy_data.dart';
import 'package:bottini/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final Uri _url = Uri.parse('https://minha_url');

  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(_url);
    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(
          Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              imageUrl: productData['imageUrl'],
              isFavorite: productData['isFavorite']),
        );
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      _url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite
      }),
    );
    _items.add(
      Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ),
    );
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
