import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';

InputDecoration inputDecoration({
  required String hintText,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 15),
    hintStyle: const TextStyle(color: Colors.black45),
    fillColor: AppColors.COLOR_GREY,
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
        color: Colors.transparent,
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
  );
}
