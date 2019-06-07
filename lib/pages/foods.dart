import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/scope-models/foodmodel.dart';

import 'package:snowjon/widgets/food.dart';

class FoodsPage extends StatelessWidget {
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
            ScopedModelDescendant<FoodModel>(
              builder: (BuildContext context, Widget child, FoodModel model) {
                return IconButton(
                  icon: model.showFavouriteOnly
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            ),
          ],
        ),
        body: ScopedModelDescendant<FoodModel>(
          builder: (BuildContext context, Widget child, FoodModel model) {
            return FoodWidget(model);
          },
        ));
  }
}
