import 'package:flutter/material.dart';

class FoodControl extends StatelessWidget {
  final Function _addFood;
  final Function _removeFood;
  final Function _clearFood;

  FoodControl(this._addFood, this._removeFood, this._clearFood);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(alignment: MainAxisAlignment.center, children: [
      RaisedButton(
        child: Text('Add Food'),
        onPressed: () {
          _addFood();
        },
      ),
      RaisedButton(
        child: Text('Remove Food'),
        onPressed: () {
          _removeFood();
        },
      ),
      RaisedButton(
        child: Text('Clear'),
        onPressed: () {
          _clearFood();
        },
      ),
    ]);
  }
}
