import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';

AppBar myAppBar(
    {required String title, double size = 21, required BuildContext context}) {
  return AppBar(
    backgroundColor: AppColors.COLOR_SWATCH,
    elevation: 0,
    leading: IconButton(
      splashRadius: 18,
      icon:
          Icon(Icons.arrow_back_outlined, color: AppColors.COLOR_BLACK),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Column(
      children: [
        Text(
          "$title",
          style: TextStyle(
            color: AppColors.COLOR_BLACK,
          ),
        )
      ],
    ),
    centerTitle: true,
  );
}
