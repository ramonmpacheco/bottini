import 'dart:convert';

import 'package:bottini/env.dart';
import 'package:bottini/exceptions/auth_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireDate;

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (this._token != null &&
        this._expireDate != null &&
        this._expireDate.isAfter(DateTime.now())) {
      return this._token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(String email, String password, String url) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    final responseBody = json.decode(response.body);

    if (responseBody['error'] != null) {
      throw AuthException(responseBody['error']['message']);
    } else {
      this._token = responseBody['idToken'];
      this._expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    final url = '${Env.SIGN_UP}${Env.APP_KEY}';
    return this._authenticate(email, password, url);
  }

  Future<void> login(String email, String password) async {
    final url = '${Env.SIGN_IN}${Env.APP_KEY}';
    return this._authenticate(email, password, url);
  }
}