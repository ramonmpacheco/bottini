import 'package:flutter/material.dart';

enum AuthMode { SIGN_UP, LOGIN }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.LOGIN;
  final _passwordController = TextEditingController();

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 320,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'E-mail invádio';
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length > 5) {
                    return 'Senha Inválida';
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              if (_authMode == AuthMode.SIGN_UP)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                  controller: _passwordController,
                  obscureText: true,
                  validator: _authMode == AuthMode.SIGN_UP
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Senhas Diferentes';
                          }
                          return null;
                        }
                      : null,
                  onSaved: (value) => _authData['email'] = value,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8.0,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                onPressed: _submit,
                child:
                    Text(_authMode == AuthMode.LOGIN ? 'ENTRAR' : 'REGISTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
