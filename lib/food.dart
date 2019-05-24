import 'package:flutter/material.dart';
import 'package:snowjon/pages/details.dart';

class Food extends StatelessWidget {
  final List<Map<String, String>> _foods;

  Food(this._foods);

  Widget _buildFood(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset(_foods[index]['imageUrl']),
        Text(_foods[index]['title']),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Details'),
              onPressed: () => Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DetailsPage(
                              _foods[index]['title'],
                              _foods[index]['imageUrl']))).then((value) {
                    if (value) {
                      _foods.removeAt(index);
                    }
                  }),
            ),
          ],
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_foods.length > 0) {
      return ListView.builder(
        itemBuilder: _buildFood,
        itemCount: _foods.length,
      );
    } else {
      return Center(child: Text('No Food Cards. Add Some !'));
    }
  }
}
