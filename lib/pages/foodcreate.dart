import 'package:flutter/material.dart';

class CreateFood extends StatefulWidget {
  final Function addFood, updateFood;
  final Map<String, dynamic> food;
  final int index;

  CreateFood({this.addFood, this.updateFood, this.food, this.index});

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
    'imageUrl': 'assets/curry.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Food Title'),
      initialValue: widget.food == null ? '' : widget.food['title'],
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

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Food Description"),
      initialValue: widget.food == null ? "" : widget.food['description'],
      maxLines: 4,
      onSaved: (String description) {
        _newFood['description'] = description;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Food Price"),
      initialValue: widget.food == null ? "" : widget.food['price'],
      keyboardType: TextInputType.number,
      onSaved: (String price) {
        _newFood['price'] = price;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (widget.food == null)
        widget.addFood(_newFood);
      else
        widget.updateFood(_newFood, widget.index);
      Navigator.pushReplacementNamed(context, 'food');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              ),
            ],
          ),
        ),
      ),
    );
    if (widget.food == null)
      return form;
    else
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Food'),
        ),
        body: form,
      );
  }
}
