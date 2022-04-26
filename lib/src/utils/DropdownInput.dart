import 'package:flutter/material.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

DropdownButtonFormField buildDropdown(
      TextEditingController form, List<String> items, String hintText) {
    return DropdownButtonFormField(
      validator: (value) => value == null ? "โปรดเลือก" : null,
      decoration: selectDecoration(hintText: hintText),
      icon: Icon(Icons.expand_more_rounded),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        form.text = value;
      },
    );
  }