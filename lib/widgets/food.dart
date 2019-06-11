import 'package:flutter/material.dart';
import 'package:snowjon/scope-models/mainmodel.dart';
import 'package:snowjon/widgets/ui_elements/geotag.dart';
import 'package:snowjon/widgets/ui_elements/pricetag.dart';
import 'package:snowjon/widgets/ui_elements/titletext.dart';

class FoodWidget extends StatelessWidget {
  final MainModel _model;

  FoodWidget(this._model);

  Widget _buildButtonBar(BuildContext context, int index) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () =>
              Navigator.pushNamed<bool>(context, '/food/' + index.toString())
                  .then((value) {
                if (value) {
                  _model.selectIndex(index);
                  _model.deleteFood();
                }
                ;
              }),
        ),
        IconButton(
          icon: _model.foods[index].isFavourite
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () {
            _model.selectIndex(index);
            _model.toggleFavourite();
          },
        ),
      ],
    );
  }

  Widget _buildFood(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            placeholder: AssetImage('assets/background.jpg'),
            image: NetworkImage(_model.foods[index].imageUrl),
            fit: BoxFit.cover,
            height: 300,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleTextWidget(_model.foods[index].title),
              SizedBox(
                width: 10.0,
              ),
              PriceTagWidget(_model.foods[index].price.toString())
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
    return ListView.builder(
      itemBuilder: _buildFood,
      itemCount: _model.foods.length,
    );
  }
}
