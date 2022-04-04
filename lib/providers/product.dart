import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> toggleFavouriteStatus() async{
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();


    final url = Uri.parse(
        'https://shop-app-19327-default-rtdb.firebaseio.com/products/$id.json');
    try{
      final response = await http.patch(url, body: json.encode(
          {
            'isFavorite' : isFavourite
          }
      ),);
      if(response.statusCode >= 400){
        isFavourite = oldStatus;
        notifyListeners();
      }
    }catch(error){
      isFavourite = oldStatus;
      notifyListeners();
    }

  }
}