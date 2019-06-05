import 'package:flutter/material.dart';

import 'allfood.dart';
import 'foodcreate.dart';

class ManageFood extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;
  final Function _addFood, _updateFood;

  ManageFood(this._addFood, this._updateFood, this._foods);

  Widget _buildTabbar() {
    return AppBar(
      title: Text('Manage Food'),
      bottom: TabBar(
        tabs: <Widget>[
          Tab(
            text: 'Create Food',
            icon: Icon(Icons.edit),
          ),
          Tab(
            text: 'All Food',
            icon: Icon(Icons.list),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.fastfood),
                title: Text('All Foods'),
                onTap: () => Navigator.pushNamed(context, 'food'),
              )
            ],
          ),
        ),
        appBar: _buildTabbar(),
        body: TabBarView(
          children: <Widget>[
            CreateFood(addFood: _addFood),
            AllFood(_updateFood, _foods)
          ],
        ),
      ),
    );
  }
}
