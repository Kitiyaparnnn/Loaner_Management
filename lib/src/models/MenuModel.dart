import 'package:flutter/material.dart';

class MenuModel {
  const MenuModel({
    required this.name,
    required this.subName,
    required this.route,
    required this.image,
    required this.color,

  });

  final String name;
  final String subName;
  final Widget route;
  final String image;
  final Color color;

}
