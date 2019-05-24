import 'package:flutter/material.dart';

import 'foods.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticate'),
      ),
      body: Center(
        child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text('Login'),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => FoodsPage()))),
      ),
    );
  }
}
