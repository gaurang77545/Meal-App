import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color; //Background Color
  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange, //default color is orange
  });
}
