import 'package:flutter/material.dart';

import '../foodmanager.dart';
import 'managefood.dart';

class FoodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('All Foods'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ManageFood())),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('My List'),
        ),
        body: FoodManager(
          startingFood: 'Food',
        ));
  }
}
