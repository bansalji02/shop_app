import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  //taking the required inputs
/*  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});*/

  @override
  Widget build(BuildContext context) {
    final product  =  Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
            },
            child: Image.network(product.imageUrl)),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon( product.isFavourite? Icons.star
              : Icons.star_border),
              color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              product.toggleFavouriteStatus();
            },),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItemsToCart(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:Text('Item added to cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                    onPressed: (){
                    cart.removeSingleItem(product.id);
                    },
                ),
              ),);
            },

          ),
        ),
      ),
    );
  }
}
