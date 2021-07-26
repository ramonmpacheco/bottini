import 'dart:convert';

import 'package:bottini/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _doToggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _doToggleFavorite();

    try {
      final url = Uri.parse(
          "${Env.BASE_URL}/userFavorites/$userId/$id.json?auth=$token");

      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _doToggleFavorite();
      }
    } catch (error) {
      _doToggleFavorite();
    }
  }
}
