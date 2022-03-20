import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/widget/product_item.dart';
import 'package:provider/provider.dart';



class ProductsGrid extends StatelessWidget {
  bool showOnlyFavourites;

  ProductsGrid(this.showOnlyFavourites);


  @override
  Widget build(BuildContext context) {
    
    final productsData = Provider.of<ProductsProvider>(context);
    final products =showOnlyFavourites?  productsData.favouriteItems: productsData.items;
    
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
       // create: (c) => products[index],
      child: ProductItem(

      ),) ,
      /*{
        return ProductItem(
          title: products[index].title,
          imageUrl: products[index].imageUrl,
          id: products[index].id,
        );
      },*/
      itemCount: products.length,
    );
  }
}
