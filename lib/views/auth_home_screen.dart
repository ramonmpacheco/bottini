import 'package:bottini/providers/auth.dart';
import 'package:bottini/views/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottini/views/products_overview_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuthenticated ? ProductOverviewScreen() : AuthScreen();
  }
}
