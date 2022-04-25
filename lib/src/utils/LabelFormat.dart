import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';

Widget label(String text) => Container(
      child: Text(
        "$text",
        style: const TextStyle(
            color: AppColors.COLOR_BLACK,
            letterSpacing: 0.15,
            fontWeight: FontWeight.w300,
            fontSize: 14),
      ),
    );
