import 'package:flutter/material.dart';

import 'food.dart';
import 'foodcontrol.dart';

class FoodManager extends StatefulWidget {
  final String startingFood;

  FoodManager({this.startingFood: 'Food'});

  @override
  State<StatefulWidget> createState() {
    return _FoodManagerState();
  }
}

class _FoodManagerState extends State<FoodManager> {
  List<Map<String, String>> _foods = [];

  @override
  void initState() {
//    _foods.add(widget.startingFood + ' ' + (_foods.length + 1).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(10.0),
            child: FoodControl(_addFood, _removeFood, _clearFood)),
        Expanded(
          child: Food(_foods),
        )
      ],
    );
  }

  void _addFood() {
    setState(() {
      _foods.add({
        'title': widget.startingFood + ' ' + (_foods.length + 1).toString(),
        'imageUrl': 'assets/curry.jpg'
      });
    });
  }

  void _removeFood() {
    setState(() {
      _foods.removeAt(0);
    });
  }

  void _clearFood() {
    setState(() {
      _foods = [];
    });
  }
}
