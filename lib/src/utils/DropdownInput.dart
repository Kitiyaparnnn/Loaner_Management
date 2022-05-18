import 'package:flutter/material.dart';
import 'package:loaner/src/models/DropdownModel.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

DropdownButtonFormField buildDropdown(
    TextEditingController form, Map<String, String> items, String hintText) {
  return DropdownButtonFormField(
    validator: (value) => value == null ? "โปรดเลือก" : null,
    decoration: selectDecoration(hintText: hintText),
    icon: Icon(Icons.expand_more_rounded),
    items: items.keys.map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem(
        value: value,
        child: Text(items[value]!),
      );
    }).toList(),
    onChanged: (value) {
      form.text = value;
    },
  );
}

DropdownButtonFormField buildDropdownInput(
    TextEditingController form, List<DropdownModel> items, String hintText) {
  return DropdownButtonFormField(
    validator: (value) => value == null ? "โปรดเลือก" : null,
    decoration: selectDecoration(hintText: hintText),
    icon: Icon(Icons.expand_more_rounded),
    items: items.map<DropdownMenuItem<String>>((item) {
      return DropdownMenuItem(
        value: item.id,
        child: Text(item.name == null ? "" : item.name!),
      );
    }).toList(),
    onChanged: (value) {
      form.text = value;
    },
  );
}
