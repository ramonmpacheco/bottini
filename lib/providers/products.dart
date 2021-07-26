import 'dart:convert';

import 'package:bottini/exceptions/http_exception.dart';
import 'package:bottini/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

class Products with ChangeNotifier {
  String _token;
  String _userId;
  List<Product> _items = [];
  final String _baseUrl = Env.PRODUCT_BASE_URL;

  Products([this._token, this._userId, this._items = const []]);

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl.json?auth=$_token"));
    Map<String, dynamic> data = json.decode(response.body);
    final favoriteResponse = await http.get(
        Uri.parse("${Env.BASE_URL}/userFavorites/$_userId.json?auth=$_token"));
    final favMap = json.decode(favoriteResponse.body);

    _items.clear();

    if (data != null) {
      data.forEach((productId, productData) {
        final isFavorite = favMap == null ? false : favMap[productId] ?? false;
        _items.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: isFavorite,
          ),
        );
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      Uri.parse("$_baseUrl.json?auth=$_token"),
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
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

  Future<void> updateProduct(Product product) async {
    if (product != null && product.id == null) {
      return;
    }

    final index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${product.id}.json?auth=$_token"),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final int index = _items.indexWhere((product) => product.id == id);

    if (index >= 0) {
      final product = _items[index];

      _items.remove(product);
      notifyListeners();

      final response = await http
          .delete(Uri.parse("$_baseUrl/${product.id}.json?auth=$_token"));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw new HttpException("Ocorreu erro na exclusão do produto.");
      }
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
