import 'package:flutter/material.dart';

class SupplierHomePage extends StatefulWidget {
  SupplierHomePage({Key? key}) : super(key: key);

  @override
  State<SupplierHomePage> createState() => _SupplierHomePageState();
}

class _SupplierHomePageState extends State<SupplierHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}