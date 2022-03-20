import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/widget/app_drawer.dart';
import 'package:flutter_complete_guide/widget/badge.dart';
import 'package:flutter_complete_guide/widget/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterStatus { favourites, all }

class ProductOverViewScreen extends StatefulWidget {
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();

  static const routeName = '/product-overview-screen';
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
    //here we can use the above line but that will trigger the whole build method to rerun
    //but we don't want that only a little part of the screen need to hear that
    //so instead of the above line we would use consumer in the part of the screen that needs this

    return Scaffold(

      //adding a drawer in the app
      drawer: Drawer(child: AppDrawer(),),

      /* Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 200),
          child: GestureDetector(
            child: Text('My Orders!'),
            onTap: (){
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
        ),
      ),*/
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show favourites'),
                value: FilterStatus.favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterStatus.all,
              )
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (FilterStatus selectedvalue) {
              setState(
                () {
                  if (selectedvalue == FilterStatus.favourites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (context, cartValue, ch) => Badge(
              child: ch,
              value: cartValue.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(cartScreen.routename);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
