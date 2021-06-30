import 'package:bottini/models/product.dart';
import 'package:bottini/providers/products.dart';
import 'package:bottini/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Tem certeza'),
                    content: Text('Quer deletar o produto?'),
                    actions: [
                      TextButton(
                          child: Text('Não'),
                          onPressed: () => Navigator.of(ctx).pop(false)),
                      TextButton(
                          child: Text('Sim'),
                          onPressed: () => Navigator.of(ctx).pop(true)),
                    ],
                  ),
                ).then((deleteConfirmed) {
                  if (deleteConfirmed) {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(product.id);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
