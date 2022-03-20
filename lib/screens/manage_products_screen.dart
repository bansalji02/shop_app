import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widget/app_drawer.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routename = '/manage-products-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Manage Products!'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: Text('MANage screen'),
      ),
    );
  }
}
