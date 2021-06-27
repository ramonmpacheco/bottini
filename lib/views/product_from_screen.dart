import 'package:flutter/material.dart';

class ProductFormScreem extends StatefulWidget {
  @override
  _ProductFormScreemState createState() => _ProductFormScreemState();
}

class _ProductFormScreemState extends State<ProductFormScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}
