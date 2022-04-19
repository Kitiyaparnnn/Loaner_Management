import 'package:flutter/material.dart';

class MapModel {
  const MapModel(
      {required this.title,
      // required this.route,
      required this.top,
      required this.left,
      required this.right});

  final String title;
  // final Widget route;
  final double top;
  final double left;
    final double right;
}
