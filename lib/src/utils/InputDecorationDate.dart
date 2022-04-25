import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';

InputDecoration inputDecorationDate({
  required String hintText,required bool isDate
}) {
  return InputDecoration(
    contentPadding:
        const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 10),
    hintStyle: const TextStyle(color: AppColors.COLOR_LIGHT, fontSize: 16),
    fillColor: AppColors.COLOR_WHITE,
    filled: true,
    hintText: '$hintText',
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: const BorderSide(
        color: AppColors.COLOR_PRIMARY,
        width: 2,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: const BorderSide(
        color: AppColors.COLOR_GREY,
        width: 1.0,
      ),
    ),
    border: new OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(10.0),
      ),
      borderSide: const BorderSide(
        color: AppColors.COLOR_PRIMARY,
        width: 1.0,
      ),
    ),
    suffixIcon:  Icon(isDate? Icons.calendar_month_outlined: Icons.access_time_filled_outlined,color: AppColors.COLOR_LIGHT,)
  );
}
