import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';


class OrderItem extends StatelessWidget {

  final  ord.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(order.amount.toString()),
        subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.datetime),),
        trailing: IconButton(icon : Icon(Icons.expand_more),
          onPressed: (){

          },
        ),
      ),
    );
  }
}
