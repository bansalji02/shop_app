import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/widget/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widget/order_item.dart' as ordItem;

class OrderScreen extends StatefulWidget {

  static const routeName = './orderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Orders>(context, listen: false).setAndFetchOrders();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),

      body: ListView.builder(itemBuilder: (ctx, index) => ordItem.OrderItem(ordersData.orders[index]),
      itemCount: ordersData.orders.length,),
    );
  }
}
