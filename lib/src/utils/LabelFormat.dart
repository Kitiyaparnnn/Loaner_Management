import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';

Widget label(String text) => Container(
        padding: const EdgeInsets.only(left: 5, bottom: 5),
        child: Text(
          "$text",
          style: const TextStyle(
              color: AppColors.COLOR_DARK,
              letterSpacing: 0.15,
              fontWeight: FontWeight.w500),
        ),
      );