import 'package:flutter/material.dart';

class GeoTagWidget extends StatelessWidget {
  final String geo;

  GeoTagWidget(this.geo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)),
      child: Text(geo),
    );
  }
}
