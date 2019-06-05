import 'package:flutter/material.dart';

class CreateFood extends StatefulWidget {
  final Function _addFood;

  CreateFood(this._addFood);

  @override
  State<StatefulWidget> createState() {
    return _CreateFoodState();
  }
}

class _CreateFoodState extends State<CreateFood> {
  String title = "";
  String description = "";
  double price = 0;

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: "Food Title"),
      onChanged: (String title) {
        this.title = title;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      decoration: InputDecoration(labelText: "Food Description"),
      maxLines: 4,
      onChanged: (String description) {
        this.description = description;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: "Food Price"),
      keyboardType: TextInputType.number,
      onChanged: (String price) {
        this.price = double.parse(price);
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> newFood = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': 'assets/curry.jpg'
    };
    widget._addFood(newFood);
    Navigator.pushReplacementNamed(context, 'food');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: _submitForm,
          )
        ],
      ),
    );
  }
}
