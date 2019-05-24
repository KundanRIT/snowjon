import 'package:flutter/material.dart';

import 'foodmanager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My List'),
          ),
          body: FoodManager('Food')),
    );
  }
}
