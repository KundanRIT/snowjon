import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/scope-models/mainmodel.dart';

import 'package:snowjon/widgets/food.dart';

class FoodsPage extends StatefulWidget {
  final MainModel model;

  FoodsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _FoodsPageState();
  }
}

class _FoodsPageState extends State<FoodsPage> {
  @override
  void initState() {
    widget.model.fetchFoods();
    super.initState();
  }

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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(
          child: Text('No Food Cards. Add Some.'),
        );
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!model.isLoading && model.foods.length > 0) {
          content = FoodWidget(model);
        }
        return Scaffold(
          drawer: _buildDrawer(context),
          appBar: AppBar(
            title: Text('My Food List'),
            actions: <Widget>[
              IconButton(
                icon: model.showFavouriteOnly
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              ),
            ],
          ),
          body: RefreshIndicator(child: content, onRefresh: model.fetchFoods),
        );
      },
    );
  }
}
