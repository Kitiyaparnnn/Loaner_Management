import 'package:flutter/material.dart';

class MenuModel {
  const MenuModel({
    required this.name,
    required this.subName,
    required this.route,
    required this.icon,
    required this.color,
    required this.isShow,
  });

  final String name;
  final String subName;
  final Widget route;
  final IconData icon;
  final Color color;
  final bool isShow;
}
