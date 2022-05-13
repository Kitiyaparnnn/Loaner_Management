import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

class SplashPage extends StatefulWidget {
  SplashPage({required this.isSupplier});
  bool isSupplier;
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.COLOR_PRIMARY,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("${Constants.IMAGE_DIR}/logo.png"),
            SizedBox(
              height: 10,
            ),
            SpinKitThreeBounce(
              itemBuilder: ((context, index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven
                            ? AppColors.COLOR_GREEN_LIGHT
                            : AppColors.COLOR_WHITE));
              }),
              duration: Duration(seconds: 2),
              size: 25.0,
            )
          ],
        ));
  }
}
