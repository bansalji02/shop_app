import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount{
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItemsToCart(String productId, String productTitle, double price) {
    if (_items.containsKey(productId)) {
      //increment the quantity
      _items.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(), title: productTitle, price: price, quantity: 1),
      );
    }
    notifyListeners();
  }

  //removing the item from the cart
   void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
   }

   //removing the single item using undo key
  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity>1){
      _items.update(productId, (value) => CartItem(id: value.id, title: value.title, price: value.price, quantity: value.quantity-1));
    }
    else{
      _items.remove(productId);
    }

    notifyListeners();
  }

   void clearCart(){
    _items = {};
    notifyListeners();
   }
}
