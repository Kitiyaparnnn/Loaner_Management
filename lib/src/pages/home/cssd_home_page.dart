import 'package:flutter/material.dart';

class CssdHomePage extends StatefulWidget {
  CssdHomePage({Key? key}) : super(key: key);

  @override
  State<CssdHomePage> createState() => _CssdHomePageState();
}

class _CssdHomePageState extends State<CssdHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}