import 'dart:async';
import 'dart:convert';

import 'package:bottini/env.dart';
import 'package:bottini/exceptions/auth_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _userId;
  String _token;
  DateTime _expireDate;
  Timer _logoutTimer;

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

  String get userId {
    return isAuthenticated ? this._userId : null;
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
      this._userId = responseBody['localId'];
      this._expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );
      _autoLogout();
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

  void logout() {
    _token = null;
    _userId = null;
    _expireDate = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }
    final timeToLogout = _expireDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }
}
