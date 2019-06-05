import 'package:flutter/material.dart';
import 'package:snowjon/pages/details.dart';
import 'package:snowjon/ui_elements/pricetag.dart';
import 'package:snowjon/ui_elements/titletext.dart';

import 'package:snowjon/ui_elements/geotag.dart';

class Food extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;

  Food(this._foods);

  Widget _buildButtonBar(BuildContext context, int index) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailsPage(_foods[index]))).then((value) {
                if (value) {
                  _foods.removeAt(index);
                }
              }),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFood(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(_foods[index]['imageUrl']),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleTextWidget(_foods[index]['title']),
              SizedBox(
                width: 10.0,
              ),
              PriceTagWidget(_foods[index]['price'].toString())
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          GeoTagWidget('Taste of India, Rochester NY'),
          _buildButtonBar(context, index)
        ],
      ),
    );
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
