import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/models/food.dart';
import 'package:snowjon/scope-models/foodmodel.dart';
import 'package:snowjon/widgets/ui_elements/geotag.dart';
import 'package:snowjon/widgets/ui_elements/pricetag.dart';
import 'package:snowjon/widgets/ui_elements/titletext.dart';

class DetailsPage extends StatelessWidget {
  final int _index;

  DetailsPage(this._index);

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
    return ScopedModelDescendant<FoodModel>(
      builder: (BuildContext context, Widget child, FoodModel model) {
        Food food = model.foods[_index];
        return Scaffold(
          appBar: AppBar(
            title: Text(food.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(food.imageUrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleTextWidget(food.title),
                  SizedBox(
                    width: 10,
                  ),
                  PriceTagWidget(food.price.toString()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GeoTagWidget('Taste of India, Rochester NY'),
              SizedBox(
                height: 10,
              ),
              Text(
                food.description,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Oswald',
                    fontStyle: FontStyle.italic),
              ),
              Container(
                child: _buildButtonBar(context),
              ),
            ],
          ),
        );
      },
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
