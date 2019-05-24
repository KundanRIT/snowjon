import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  final List<String> _foods;

  Food(this._foods);

  Widget _displayFood(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[Image.asset('assets/curry.jpg'), Text(_foods[index])],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _displayFood,
      itemCount: _foods.length,
    );
  }
}
