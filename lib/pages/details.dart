import 'package:flutter/material.dart';
import 'package:snowjon/ui_elements/geotag.dart';
import 'package:snowjon/ui_elements/pricetag.dart';
import 'package:snowjon/ui_elements/titletext.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> _food;

  DetailsPage(this._food);

  Widget _buildButtonBar(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            'DELETE',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        )
      ],
    );
  }

  Widget _buildFoodCard(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_food['title']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(_food['imageUrl']),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleTextWidget(_food['title']),
              SizedBox(
                width: 10,
              ),
              PriceTagWidget(_food['price'].toString()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GeoTagWidget('Taste of India, Rochester NY'),
          Container(
            child: _buildButtonBar(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: _buildFoodCard(context),
    );
  }
}
