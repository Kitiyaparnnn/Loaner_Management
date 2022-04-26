import 'package:flutter/material.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/InputDecoration.dart';

TextFormField buildTextFormField(TextEditingController text, String hintText) {
  return TextFormField(
      validator: (value) => value == "" ? "โปรดกรอกข้อมูล" : null,
      controller: text,
      decoration: inputDecoration(hintText: hintText));
}

TextFormField buildLongTextFormField(
    TextEditingController text, String hintText) {
  return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      validator: (value) => value == null ? "โปรดกรอกข้อมูล" : null,
      controller: text,
      decoration: inputDecoration(hintText: hintText));
}

TextFormField buildStockTextFormField(TextEditingController text) {
  return TextFormField(
      validator: (value) => value == "" ? "โปรดกรอกข้อมูล" : null,
      controller: text,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 10),
        fillColor: AppColors.COLOR_WHITE,
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "จำนวนชิ้นในกล่อง",
                style: TextStyle(color: AppColors.COLOR_LIGHT, fontSize: 16),
              ),
            ],
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ชิ้น",
                style: TextStyle(color: AppColors.COLOR_LIGHT, fontSize: 16),
              ),
            ],
          ),
        ),
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
      ));
}
