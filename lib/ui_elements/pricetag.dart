import 'package:flutter/material.dart';

class PriceTagWidget extends StatelessWidget {

  final String price;

  PriceTagWidget(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        '\$ $price',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
