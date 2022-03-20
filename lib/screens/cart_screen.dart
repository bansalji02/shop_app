import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import '../providers/cart.dart' show Cart;//this show ensures that i import only CART from that file weeeeeeeeeeee
import 'package:provider/provider.dart';
import '../widget/cart_item.dart';

class cartScreen extends StatelessWidget {

  static const routename = './cart_screen';


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);



    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 20,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('${cart.totalAmount}'),
                    backgroundColor: ThemeData.light().colorScheme.primary,
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(child: Text('Order Now'),
                  onPressed: (){
                    Provider.of<Orders>(context,listen:  false).addOrders(cart.items.values.toList(), cart.totalAmount);
                    cart.clearCart();
                  },),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: ListView.builder(itemBuilder: (ctx, index)=> CartItem(id: cart.items.values.toList()[index].id,
              title: cart.items.values.toList()[index].title,
              price: cart.items.values.toList()[index].price,
              quantity: cart.items.values.toList()[index].quantity,
          productId: cart.items.keys.toList()[index]),//here i will add the cartitem widget,
          itemCount: cart.itemCount,))
        ],
      ),
    );
  }
}
