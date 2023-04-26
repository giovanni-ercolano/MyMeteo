import 'package:flutter/material.dart';

class PreferitePage extends StatefulWidget {
  static const String routeName = '/preferite';

  @override
  _PreferitePageState createState() => _PreferitePageState();
}

class _PreferitePageState extends State<PreferitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Preferite'),
    );
  }
}
