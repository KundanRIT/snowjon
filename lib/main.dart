import 'package:flutter/material.dart';
import 'package:snowjon/pages/auth.dart';
import 'package:snowjon/pages/foods.dart';
import 'package:snowjon/pages/managefood.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Map<String, dynamic>> _foods = [];
  String startingFood = 'Food';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
          brightness: Brightness.light),
      routes: {
        'food': (BuildContext context) => FoodsPage(_foods),
        'managefood': (BuildContext context) =>
            ManageFood(_addFood, _updateFood, _foods)
      },
    );
  }

  void _addFood(Map<String, dynamic> newFood) {
    setState(() {
      _foods.add(newFood);
    });
  }

  void _updateFood(Map<String, dynamic> food, int index) {
    setState(() {
      _foods[index] = food;
    });
  }
}
