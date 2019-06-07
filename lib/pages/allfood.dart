import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/scope-models/foodmodel.dart';

import 'foodcreate.dart';

class AllFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FoodModel>(builder: (BuildContext context, Widget child, FoodModel model) {
      if (model.foods.length > 0) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.foods[index].title),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectIndex(index);
                  model.deleteFood();
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.foods[index].imageUrl),
                    ),
                    title: Text(model.foods[index].title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        model.selectIndex(index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return CreateFood();
                          }),
                        );
                      },
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.foods.length,
        );
      } else {
        return Center(child: Text('No Food Cards. Add Some !'));
      }
    },);
  }
}
