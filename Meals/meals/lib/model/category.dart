import 'package:flutter/material.dart';

class Category {
  const Category({required this.id,
            required this.color,
            required this.title});
  final String id;
  final String title;
  final Color color;
}