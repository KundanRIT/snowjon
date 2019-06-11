import 'package:flutter/material.dart';

class Food {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  final String userId;
  final String email;

  Food({
    @required this.id,
    @required this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavourite = false,
    this.userId,
    this.email,
  });
}
