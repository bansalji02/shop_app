import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> addOrders(List<CartItem> cartItems, double totalAmount) async {
    final url = Uri.parse(
        'https://shop-app-19327-default-rtdb.firebaseio.com/orders.json');

    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': totalAmount,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartItems
            .map((cp) => {
                  'id': cp.id,
                  'price': cp.price,
                  'quantity': cp.quantity,
                  'title': cp.title,
                })
            .toList()
      }),
    );

    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          products: cartItems,
          amount: totalAmount,
          datetime: timeStamp),
    );
    notifyListeners();
  }

  Future<void> setAndFetchOrders() async {
    final url = Uri.parse(
        'https://shop-app-19327-default-rtdb.firebaseio.com/orders.json');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrdersList = [];
    if(extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrdersList.add(
        OrderItem(
          id: orderId,
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantity: item['quantity']),
              )
              .toList(),
          amount: orderData['amount'],
          datetime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });
    _orders = loadedOrdersList.reversed.toList();
    notifyListeners();
  }
}
