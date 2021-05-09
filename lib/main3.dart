import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal, accentColor: Colors.black),
    home: new Scaffold(
    appBar: AppBar(
    title: Text(
    "Denemeler",
    style: TextStyle(fontSize: 36, color: Colors.white),
  ),
  ),
  floatingActionButton: FloatingActionButton(
  onPressed: () {
  debugPrint("FAB tıklandı");
  },
  //backgroundColor: Colors.orange,
  child: new Icon(
  Icons.access_alarms,
  color: Colors.white,
  size: 48.0,
  )),
  floatingActionButtonLocation:
  FloatingActionButtonLocation.centerDocked,
  body: Container(
  color: Colors.red,
  child: Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
  Icon(Icons.waves, size: 64, color: Colors.yellow),
  Icon(Icons.add_circle, size: 64, color: Colors.blue),
  Icon(Icons.add_circle, size: 64, color: Colors.orange),
  Icon(Icons.add_circle, size: 64, color: Colors.purple),

  ],
  ),
  ))));
}
