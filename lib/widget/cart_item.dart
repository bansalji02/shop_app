import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String title;
  final int quantity;
  final String id;
  final double price;
  //here we have to accept an product id from the constructor to pass in the dismissible method as it is different
  final String productId;

  CartItem(
      {@required this.quantity,
      @required this.id,
      @required this.price,
      @required this.title,
      @required this.productId});

  @override
  Widget build(BuildContext context) {
    //using the cart provider
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes!')),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No!'),
                    ),
                  ],
                ));
      },
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.all(10),
        color: ThemeData.light().colorScheme.primary,
        child: Icon(
          Icons.delete,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text(price.toString()),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              (quantity * price).toString(),
            ),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
