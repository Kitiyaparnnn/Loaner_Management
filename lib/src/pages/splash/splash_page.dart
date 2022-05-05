import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/utils/AppColors.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 10),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.COLOR_PRIMARY,
      child: Center(
          child: Column(
        children: [Text("Loaner Management")],
      )),
    );
  }
}
