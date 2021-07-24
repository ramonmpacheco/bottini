import 'dart:convert';

import 'package:bottini/env.dart';
import 'package:bottini/exceptions/auth_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
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
