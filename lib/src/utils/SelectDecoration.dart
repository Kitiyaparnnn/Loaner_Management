import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';

InputDecoration selectDecoration(
        {String hintText = "กรุณาเลือก", double radius = 10}) =>
    InputDecoration(
      labelStyle: TextStyle(
        color: Colors.black45,
        backgroundColor: AppColors.COLOR_GREY,
      ),
      contentPadding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
      hintText: '$hintText',
      // labelText: '$labelText',
      hintStyle: TextStyle(color: Colors.black45),
      fillColor: AppColors.COLOR_GREY,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        borderSide: BorderSide(
          color: AppColors.COLOR_PRIMARY,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        borderSide: BorderSide(
          color: AppColors.COLOR_DARK,
          width: 1,
        ),
      ),
      // enabled: false,
      // suffixIcon: Icon(Icons.expand_more_rounded),
    );
