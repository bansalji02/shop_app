import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem(
      {@required this.id,
      @required this.products,
      @required this.amount,
      @required this.datetime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartitems, double totalAmount) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            products: cartitems,
            amount: totalAmount,
            datetime: DateTime.now()));
    notifyListeners();
  }
}
