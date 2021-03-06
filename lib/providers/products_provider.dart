



import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/http_exceptions.dart';
import './product.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {


  List<Product> _items = [
    /* Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  //recieving the auth token from the constructor
  final String authToken;

  ProductsProvider(this.authToken ,this._items);//here we have to initialize the list of items just to make sure that we dont loose the previous data




  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items?.where((element) => element.isFavourite == true).toList();
  }

  Product findById(String id) {
    return items?.firstWhere((element) => element.id == id);
  }

  Future<void> setAndFetchProduct() async {
    final url = Uri.parse(
        'https://shop-app-19327-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await https.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProductList = [];
      extractedData.forEach((prodId, prodData) {
        loadedProductList.add(
          Product(
              id: prodId,
              imageUrl: prodData['imageUrl'],
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavourite: prodData['isFavorite']),
        );
        _items = loadedProductList;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProducts(Product product) async {
    //sending the https request to the server
    final url = Uri.parse(
        'https://shop-app-19327-default-rtdb.firebaseio.com/products.json');
    //here we can also use return https and then function on this future but
    //here instead we are using the async keyword

    try {
      final response = await https.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavourite
          },
        ),
      );

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title);
      _items?.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  //making an update product function
  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://shop-app-19327-default-rtdb.firebaseio.com/products/$id.json');
      await https.patch(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl
          },
        ),
      );
      _items[productIndex] = product;
      notifyListeners();
    } else {
      print('bhow bhow bhow');
    }
  }

  void deleteProduct(String id) async{
    final url = Uri.parse(
        'https://shop-app-19327-default-rtdb.firebaseio.com/products/$id.json');
    //here we are extracting the index first and then making an ovjext of the product just so that we can rollback the
    //delete in case and error occcurs

    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response  =  await  https.delete(url);
      if(response.statusCode >= 400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Product could not be deleted!');

      }
      existingProduct = null;

  }
}
