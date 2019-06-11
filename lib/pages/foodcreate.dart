import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/models/food.dart';
import 'package:snowjon/scope-models/mainmodel.dart';

class CreateFood extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateFoodState();
  }
}

class _CreateFoodState extends State<CreateFood> {
  final Map<String, dynamic> _newFood = {
    'title': '',
    'description': '',
    'price': 0.0,
    'imageUrl':
        'http://www.northhantsmum.co.uk/wp-content/uploads/sites/3/2018/03/chicken-Katsu.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Food food) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Food Title'),
      initialValue: food == null ? '' : food.title,
      validator: (String title) {
        if (title.trim().isEmpty) {
          return 'Title is Required.';
        }
      },
      onSaved: (String title) {
        _newFood['title'] = title;
      },
    );
  }

  Widget _buildDescriptionTextField(Food food) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Food Description"),
      initialValue: food == null ? "" : food.description,
      maxLines: 4,
      onSaved: (String description) {
        _newFood['description'] = description;
      },
    );
  }

  Widget _buildPriceTextField(Food food) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Food Price"),
      initialValue: food == null ? "" : food.price.toString(),
      keyboardType: TextInputType.number,
      onSaved: (String price) {
        _newFood['price'] = double.parse(price);
      },
    );
  }

  void _submitForm(MainModel model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (model.selectedFood == null)
        model.addFood(_newFood).then((bool success) {
          if (success) {
            Navigator.pushReplacementNamed(context, 'food');
          } else {
            showDialog(
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Please Try Again'),
                  actions: <Widget>[
                    FlatButton(child: Text('Ok!'), onPressed: () {
                      Navigator.of(context).pop();
                    },)
                  ],
                );
              },
              context: context,
            );
          }
        });
      else
        model.updateFood(_newFood).then((bool success) {
          if (success) {
            Navigator.pushReplacementNamed(context, 'food');
          } else {
            showDialog(
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Please Try Again'),
                  actions: <Widget>[
                    FlatButton(child: Text('Ok!'), onPressed: () {
                      Navigator.of(context).pop();
                    },)
                  ],
                );
              },
              context: context,
            );
          }
        });
    }
  }

  Widget _submitButton(MainModel model) {
    return model.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () => _submitForm(model));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget form = GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  _buildTitleTextField(model.selectedFood),
                  _buildDescriptionTextField(model.selectedFood),
                  _buildPriceTextField(model.selectedFood),
                  SizedBox(
                    height: 10.0,
                  ),
                  _submitButton(model),
                ],
              ),
            ),
          ),
        );
        if (model.selectedIndex == null)
          return form;
        else
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Food'),
            ),
            body: form,
          );
      },
    );
  }
}
