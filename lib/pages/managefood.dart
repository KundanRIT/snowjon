import 'package:flutter/material.dart';

import 'foods.dart';

class ManageFood extends StatelessWidget {
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
                      builder: (BuildContext context) => FoodsPage())),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Manage Food'),
      ),
    );
  }
}
