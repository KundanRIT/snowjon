import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/scope-models/mainmodel.dart';

import 'foodcreate.dart';

class AllFood extends StatefulWidget {
  final MainModel model;

  AllFood(this.model);

  @override
  State<StatefulWidget> createState() {
    return _AllFoodState();
  }
}

class _AllFoodState extends State<AllFood> {
  @override
  void initState() {
    widget.model.fetchFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Food Cards. Add Some !'));
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!model.isLoading && model.foods.length > 0) {
          content = ListView.builder(
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
                        backgroundImage:
                            NetworkImage(model.foods[index].imageUrl),
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
        }
        return content;
      },
    );
  }
}
