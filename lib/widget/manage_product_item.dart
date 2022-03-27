import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';


class ManageProductItem extends StatelessWidget {

  final String title;
  final String imageUrl;
  final String id;

  ManageProductItem({ @required this.title,@required this.imageUrl, @required this.id});


  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing:Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditProductsScreen.routeName, arguments: id);
            }, icon: Icon(Icons.edit),),
            IconButton(onPressed: (){
              Provider.of<ProductsProvider>(context,listen: false).deleteProduct(id);
            }, icon: Icon(Icons.delete),),
          ],
        ),
      ),
    );
  }
}
