import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite ;

  Product({
    @required this.id,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavourite = false,
    @required this.title,
});

  void toggleFavouriteStatus(){
    isFavourite = !isFavourite;
    notifyListeners();
  }
}