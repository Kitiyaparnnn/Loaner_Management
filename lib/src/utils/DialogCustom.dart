import 'package:flutter/material.dart';

import 'Constants.dart';

dialogCustom({required BuildContext context, required String title, required String content}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(Constants.TEXT_CONFIRM),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}