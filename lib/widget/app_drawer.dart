import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/manage_products_screen.dart';
import 'package:flutter_complete_guide/screens/product_overview_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text('My Orders!',
                style: TextStyle(
                  fontSize: 20
                ),),
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text('Shop!',
                  style: TextStyle(
                      fontSize: 20
                  ),),
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed(ProductOverViewScreen.routeName);
            },
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text('Manage Products',
                  style: TextStyle(
                      fontSize: 20
                  ),),
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed(ManageProductsScreen.routename);
            },
          )

        ],
      ),

    );

  }
}



 /*    Container(
       child: Column(
         
          children: [
         Container(
           height: 50,
           padding: EdgeInsets.only(top: 200),
           child: GestureDetector(
              child: Text('My Orders!'),
              onTap: () {
                Navigator.of(context).pushNamed(OrderScreen.routeName);
              },
            ),
          ),
        Container(
          height: 50,
          child: GestureDetector(
            child: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushNamed(ProductOverViewScreen.routeName);
            },
          ),
        ),
        Container(
          height: 50,
          child: GestureDetector(
            child: Text('Manage Products'),
            onTap: (){
              Navigator.of(context).pushNamed(ManageProductsScreen.routename);
            },
          ),
        )
    ]),
     );
  }
}
*/