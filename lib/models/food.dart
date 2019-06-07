import 'package:flutter/material.dart';

class Food {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavourite;

  Food({
    @required this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavourite = false,
  });
}
