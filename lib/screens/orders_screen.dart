import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widget/order_item.dart' as ordItem;

class OrderScreen extends StatelessWidget {

  static const routeName = './orderScreen';



  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),

      body: ListView.builder(itemBuilder: (ctx, index) => ordItem.OrderItem(ordersData.orders[index]),
      itemCount: ordersData.orders.length,),
    );
  }
}
