import 'package:crudemployeeapp/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

final routes = {
  '/home': (BuildContext context) => new Home(),
  '/': (BuildContext context) => new Home(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sqflite App',
      routes: routes,
    );
  }
}