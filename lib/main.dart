import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.teal, accentColor: Colors.cyanAccent),
        home: Scaffold(
            appBar: AppBar(
              title: Text('TicTacToe'),
            ),
            body: MyHomePage()));
  }
}
