import 'package:flutter/material.dart';

import 'package:snowjon/widgets/food.dart';

class FoodsPage extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;

  FoodsPage(this._foods);

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Foods'),
            onTap: () => Navigator.pushNamed(context, 'managefood'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('My Food List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            )
          ],
        ),
        body: Food(_foods));
  }
}
