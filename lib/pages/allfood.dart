import 'package:flutter/material.dart';

import 'foodcreate.dart';

class AllFood extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;
  final Function _updateFood;

  AllFood(this._updateFood, this._foods);

  @override
  Widget build(BuildContext context) {
    if (_foods.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            leading: Image.asset(_foods[index]['imageUrl']),
            title: Text(_foods[index]['title']),
            trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CreateFood(
                        food: _foods[index],
                        index: index,
                        updateFood: _updateFood);
                  }));
                }),
          );
        },
        itemCount: _foods.length,
      );
    } else {
      return Center(child: Text('No Food Cards. Add Some !'));
    }
  }
}
