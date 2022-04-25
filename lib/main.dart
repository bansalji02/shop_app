import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/screens/manage_products_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          update: (ctx, auth, previousProducts) => ProductsProvider(
            auth.token,
            previousProducts.items == null ? [] : previousProducts.items,
             // previousProducts.items
          ),
        ),
        ChangeNotifierProvider.value(
          value  :Cart(),
        ),
        ChangeNotifierProvider.value(
          value:  Orders(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, authdata, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xff6d4c41),
              ),
              colorScheme: const ColorScheme.light(
                primary: Color(0xff6d4c41),
                secondary: Color(0xff774210),
              ),
              fontFamily: 'Lato'),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            cartScreen.routename: (ctx) => cartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            ProductOverViewScreen.routeName: (ctx) => ProductOverViewScreen(),
            ManageProductsScreen.routename: (ctx) => ManageProductsScreen(),
            EditProductsScreen.routeName: (ctx) => EditProductsScreen(),
          },
          home: authdata.isAuth ? ProductOverViewScreen() : AuthScreen(),
        ),
      ),
    );
  }
}
